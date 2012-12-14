#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/recommender/client'
require 'jubatus/recommender/types'
require 'jubatus_test/test_util'

class RecommenderTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23003
  TIMEOUT = 10

  def setup
    @config = {
        "method" => "inverted_index",
        "converter" => {
            "string_filter_types" => {},
            "string_filter_rules" => [],
            "num_filter_types" => {},
            "num_filter_rules" => [],
            "string_types" => {},
            "string_rules" => [{"key" => "*", "type" => "str",  "sample_weight" => "bin", "global_weight" => "bin"}],
            "num_types" => {},
            "num_rules" => [{"key" => "*", "type" => "num"}]
        }
    }

    TestUtil.write_file("config_recommender.json", config.to_json)
    @srv = TestUtil.fork_process("recommender", PORT, "config_recommender.json")
    @cli = Jubatus::Client::Recommender.new(HOST, PORT)
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_config
    config = @cli.get_config("name")
    assert_equal(@config.to_json, JSON.parse(config).to_json)

  end


  def test_complete_row
    @cli.clear_row("name", "complete_row")
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    @cli.update_row("name", "complete_row", d)
    d1 = @cli.complete_row_from_id("name", "complete_row")
    d2 = @cli.complete_row_from_data("name", d)

  end


  def test_similar_row
    @cli.clear_row("name", "similar_row")
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    @cli.update_row("name", "similar_row", d)
    s1 = @cli.similar_row_from_id("name", "similar_row", 10)
    s2 = @cli.similar_row_from_data("name", d, 10)

  end


  def test_decode_row
    @cli.clear_row("name", "decode_row")
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    @cli.update_row("name", "decode_row", d)
    decoded_row = @cli.decode_row("name", "decode_row")
    assert_equal(d.string_values, decoded_row.string_values)
    assert_equal(d.num_values, decoded_row.num_values)
  end


  def test_get_row
    @cli.clear("name")
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    @cli.update_row("name", "get_row", d)
    row_names = @cli.get_all_rows("name")
    assert_equal(row_names, ["get_row"])

  end


  def test_clear
    @cli.clear("name")

  end


  def test_calcs
    string_values = [["key1", "val1"], ["key2", "val2"]]
    num_values = [["key1", 1.0], ["key2", 2.0]]
    d = Jubatus::Datum.new(string_values, num_values)
    assert_in_delta(@cli.similarity("name", d, d), 1, 0.000001)
    assert_in_delta(@cli.l2norm("name", d), Math.sqrt(1*1 + 1*1+ 1*1 + 2*2), 0.000001)

  end


  def test_clear
    @cli.clear("name")

  end


  def test_save
    assert_equal(@cli.save("name", "recommender.save_test.model"), true)

  end


  def test_load
    model_name = "recommender.load_test.model"
    @cli.save("name", model_name)
    assert_equal(@cli.load("name", model_name), true)

  end


  def test_get_status
    @cli.get_status("name")

  end


end

