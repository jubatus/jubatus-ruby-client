require 'test/unit'
require 'jubatus/common'
require 'msgpack/rpc'

module Jubatus
module Common

class DummyFuture
  def initialize(result, error)
    @result = result
    @error = error
    @handler = nil
  end


  def attach_error_handler(proc = nil, &block)
    @handler = proc || block
  end

  def get
    if @error
        if @handler
          @handler.call(@error, @result)
        else
          raise MessagePack::RPC::RPCError.create(@error, @result)
        end
    else
      return @result
    end
  end
end

class DummyClient
  def call_async_apply(method, args)
      return send_request(method, args)
  end
end

# When a given method is not supported, jubatus-rpc server returns error code 1
class AlwaysRaiseUnknownMethod < DummyClient
  def send_request(method, args)
    DummyFuture.new(nil, 1)
  end
end

# When given arguments cannot be parsed, jubatus-rpc server returns error code 2
class AlwaysRaiseTypeMismatch < DummyClient
  def send_request(method, args)
    DummyFuture.new(nil, 2)
  end
end

class AlwaysRaiseRemoteError < DummyClient
  def send_request(method, args)
    DummyFuture.new(nil, "error")
  end
end

class Echo < DummyClient
  def send_request(method, args)
    DummyFuture.new(method, nil)
  end
end

class AnyType
  def to_msgpack(v)
    return v
  end

  def from_msgpack( v)
    return v
  end
end

class ClientTest < Test::Unit::TestCase
  def test_unknown_method
    c = Jubatus::Common::Client.new(AlwaysRaiseUnknownMethod.new, "name")
    assert_raise(Jubatus::Common::UnknownMethod) {
      c.call("test", [], nil, [])
    }
  end

  def test_type_mismatch
    c = Jubatus::Common::Client.new(AlwaysRaiseTypeMismatch.new, "name")
    assert_raise(Jubatus::Common::TypeMismatch) {
      c.call("test", [], nil, [])
    }
  end

  def test_remote_error
    c = Jubatus::Common::Client.new(AlwaysRaiseRemoteError.new, "name")
    assert_raise(MessagePack::RPC::RemoteError) {
      c.call("test", [], nil, [])
    }
  end

  def test_wrong_number_of_arguments
    c = Jubatus::Common::Client.new(Echo.new, "name")
    assert_equal("test", c.call("test", [], AnyType.new, []))
  end
end

end
end
