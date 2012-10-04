#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus_test/test_util'

require 'jubatus/classifier/client'
require 'jubatus/classifier/types'

class ClassifierTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23001
  TIMEOUT = 10

  def setup
    @srv = TestUtil.fork_process("classifier", PORT)
    @cli = Jubatus::Client::Classifier.new(HOST, PORT)
    method = "AROW"
    @config = "{\n\"string_filter_types\":{}, \n\"string_filter_rules\":[], \n\"num_filter_types\":{}, \n\"num_filter_rules\":[], \n\"string_types\":{}, \n\"string_rules\":\n[{\"key\":\"*\", \"type\":\"str\", \n\"sample_weight\":\"bin\", \"global_weight\":\"bin\"}\n], \n\"num_types\":{}, \n\"num_rules\":[\n{\"key\":\"*\", \"type\":\"num\"}\n]\n}"
    cd = Jubatus::Config_data.new(method, @config)
    @cli.set_config("name", cd)

  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_config
    config = @cli.get_config("name")
    assert_equal(config.method, "AROW")
    assert_equal(config.config, @config)

  end


  def test_train
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    data = [["label", d]]
    assert_equal(@cli.train("name", data), 1)

  end


  def test_classify
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
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

