#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/regression/client'
require 'jubatus/regression/types'
require 'jubatus_test/test_util'

class RegressionTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23002
  TIMEOUT = 10

  def setup
    @config = {
        "method" => "PA",
        "converter" => {
            "string_filter_types" => {},
            "string_filter_rules" => [],
            "num_filter_types" => {},
            "num_filter_rules" => [],
            "string_types" => {},
            "string_rules" => [{"key" => "*", "type" => "str",  "sample_weight" => "bin", "global_weight" => "bin"}],
            "num_types" => {},
            "num_rules" => [{"key" => "*", "type" => "num"}]
        },
        "parameter" => {
            "sensitivity" => 0.1,
            "regularization_weight" => 3.402823e+38
        }
    }

    TestUtil.write_file("config_regression.json", @config.to_json)
    @srv = TestUtil.fork_process("regression", PORT, "config_regression.json")
    @cli = Jubatus::Regression::Client::Regression.new(HOST, PORT, "name")
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_client
    assert_instance_of( MessagePack::RPC::Client, @cli.get_client )
  end

  def test_get_config
    config = @cli.get_config
    assert_equal(JSON.parse(config), @config)
  end

  def test_train
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Common::Datum.new(string_values, num_values)
    data = [[1.0, d]]
    assert_equal(@cli.train(data), 1)
  end

  def test_estimate
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Common::Datum.new(string_values, num_values)
    data = [d]
    result = @cli.estimate(data)
  end

  def test_save
    assert_equal(@cli.save("regression.save_test.model"), true)
  end

  def test_load
    model_name = "regression.load_test.model"
    @cli.save(model_name)
    assert_equal(@cli.load(model_name), true)
  end

  def test_get_status
    @cli.get_status
  end

end

