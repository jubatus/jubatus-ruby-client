require 'json'
require 'test/unit'
require 'jubatus/common'
require 'jubatus_test/test_util'

class ErrorTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23000
  TIMEOUT = 10

  def setup
    @config = {
        "method" => "AROW",
        "converter" => {
            "string_filter_types" => {},
            "string_filter_rules" => [],
            "num_filter_types" => {},
            "num_filter_rules" => [],
            "string_types" => {},
            "string_rules" => [],
            "num_types" => {},
            "num_rules" => []
        },
        "parameter" => {
            "regularization_weight" => 1.001
        }
    }

    TestUtil.write_file("config_for_error.json", @config.to_json)
    @srv = TestUtil.fork_process("classifier", PORT, "config_for_error.json")
    cli = MessagePack::RPC::Client.new(HOST, PORT)
    @cli = Jubatus::Common::Client.new(cli, "name")
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_unknownmethod
    assert_raise(Jubatus::Common::UnknownMethod) {
      @cli.call("unknown_method", [], nil, [])
    }
  end

  def test_typemismatch
    # 'train' method requires list of labeled datum, but this test sends a string.
    assert_raise(Jubatus::Common::TypeMismatch) {
      @cli.call("train", [""], nil, [Jubatus::Common::TString.new])
    }
  end
end
