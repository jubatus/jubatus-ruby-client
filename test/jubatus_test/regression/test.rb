#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus_test/test_util'

require 'jubatus/regression/client'
require 'jubatus/regression/types'

class RegressionTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23002
  TIMEOUT = 10

  def setup
    @srv =  TestUtil.fork_process("regression", PORT)
    @cli = Jubatus::Client::Regression.new(HOST, PORT)
    method = "PA"
    @converter = "{\n\"string_filter_types\":{}, \n\"string_filter_rules\":[], \n\"num_filter_types\":{}, \n\"num_filter_rules\":[], \n\"string_types\":{}, \n\"string_rules\":\n[{\"key\":\"*\", \"type\":\"str\", \n\"sample_weight\":\"bin\", \"global_weight\":\"bin\"}\n], \n\"num_types\":{}, \n\"num_rules\":[\n{\"key\":\"*\", \"type\":\"num\"}\n]\n}"
    cd = Jubatus::Config_data.new(method, @converter)
    @cli.set_config("name", cd)

  end


  def teardown
    TestUtil.kill_process(@srv)
  end


  def test_get_config
    config = @cli.get_config("name")
    assert_equal(config.method, "PA")
    assert_equal(config.config, @converter)

  end


  def test_train
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    data = [[1.0, d]]
    assert_equal(@cli.train("name", data), 1)

  end


  def test_estimate
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    data = [d]
    result = @cli.estimate("name", data)

  end


  def test_save
    assert_equal(@cli.save("name", "regression.save_test.model"), true)

  end


  def test_load
    model_name = "regression.load_test.model"
    @cli.save("name", model_name)
    assert_equal(@cli.load("name", model_name), true)

  end


  def test_get_status
    @cli.get_status("name")

  end


end

