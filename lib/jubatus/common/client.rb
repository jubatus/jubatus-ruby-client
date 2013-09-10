module Jubatus
module Common

class RemoteError < Exception; end
class UnknownMethod < Exception; end
class TypeMismatch < Exception; end

class Client
  def initialize(client, name)
    @client = client
    # @client.attach_error_handler do |error, result|
    #   if error == 1
    #     raise UnknownMethod, result
    #   elsif error == 2
    #     raise TypeMismatch, result
    #   else
    #     raise RemoteError, result
    #   end
    # end

    @name = name
  end

  def translate_error(e)
    # RPCError of msgpack-rpc library only stores string of  error object.
    if e.code == "1"
      raise UnknownMethod, e.to_s
    elsif e.code == "2"
      # TODO(unno) we cannot get which arugment is illegal
      raise TypeMismatch, e.to_s
    else
      raise RemoteError, e.to_s
    end
  end

  def call(method, args, ret_type, args_type)
    if args.size != args_type.size
      raise "number of arguemnts for \"%s\" must to be %d, but %d arguments are given" % [method, args_type.size, args.size]
    end
    values = [@name]
    args.zip(args_type).each do |v, t|
      values << t.to_msgpack(v)
    end
    begin
      ret = @client.call(method, *values)
    rescue MessagePack::RPC::RemoteError => e
      translate_error(e)
    end

    if ret_type != nil
      return ret_type.from_msgpack(ret)
    end
  end
end

end
end
