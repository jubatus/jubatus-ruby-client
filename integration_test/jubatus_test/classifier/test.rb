#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/classifier/client'
require 'jubatus/classifier/types'
require 'jubatus_test/test_util'

class ClassifierTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23001
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
            "string_rules" => [{"key" => "*", "type" => "str",  "sample_weight" => "bin", "global_weight" => "bin"}],
            "num_types" => {},
            "num_rules" => [{"key" => "*", "type" => "num"}]
        },
        "parameter" => {
            "regularization_weight" => 1.001
        }
    }

    TestUtil.write_file("config_classifier.json", @config.to_json)
    @srv = TestUtil.fork_process("classifier", PORT, "config_classifier.json")
    @cli = Jubatus::Classifier::Client::Classifier.new(HOST, PORT)
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_client
    assert_instance_of( MessagePack::RPC::Client, @cli.get_client )
  end

  def test_get_config
    config = @cli.get_config("name")
    assert_equal(JSON.parse(config), @config)
  end

  def test_train
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Common::Datum.new(string_values, num_values)
    data = [["label", d]]
    assert_equal(@cli.train("name", data), 1)
  end

  def test_classify
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Common::Datum.new(string_values, num_values)
    data = [d]
    result = @cli.classify("name", data)
  end

  def test_save
    assert_equal(@cli.save("name", "classifier.save_test.model"), true)
  end

  def test_load
    model_name = "classifier.load_test.model"
    @cli.save("name", model_name)
    assert_equal(@cli.load("name", model_name), true)
  end

  def test_get_status
    @cli.get_status("name")
  end

end
