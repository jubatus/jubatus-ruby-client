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

    TestUtil.write_file("config_recommender.json", @config.to_json)
    @srv = TestUtil.fork_process("recommender", PORT, "config_recommender.json")
    @cli = Jubatus::Recommender::Client::Recommender.new(HOST, PORT, "name")
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

  def test_complete_row
    @cli.clear_row("complete_row")
    d = Jubatus::Common::Datum.new({"skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0})
    @cli.update_row("complete_row", d)
    d1 = @cli.complete_row_from_id("complete_row")
    d2 = @cli.complete_row_from_datum(d)
  end

  def test_get_similar_row
    @cli.clear_row("similar_row")
    d = Jubatus::Common::Datum.new({"skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0})
    @cli.update_row("similar_row", d)
    s1 = @cli.similar_row_from_id("similar_row", 10)
    s2 = @cli.similar_row_from_datum(d, 10)
  end

  def test_decode_row
    @cli.clear_row("decode_row")
    d = Jubatus::Common::Datum.new({"skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0})
    @cli.update_row("decode_row", d)
    decoded_row = @cli.decode_row("decode_row")
    assert_equal(d.string_values, decoded_row.string_values)
    assert_equal(d.num_values, decoded_row.num_values)
  end

  def test_get_row
    @cli.clear
    d = Jubatus::Common::Datum.new({"skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0})
    @cli.update_row("get_row", d)
    row_names = @cli.get_all_rows
    assert_equal(row_names, ["get_row"])
  end


  def test_clear
    @cli.clear
  end

  def test_calcs
    d = Jubatus::Common::Datum.new({"skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0})
    assert_in_delta(@cli.calc_similarity(d, d), 1, 0.000001)
    assert_in_delta(@cli.calc_l2norm(d), Math.sqrt(1*1 + 1*1+ 1*1 + 2*2), 0.000001)
  end

  def test_clear
    @cli.clear
  end

  def test_save
    assert_equal(@cli.save("recommender.save_test.model"), true)
  end

  def test_load
    model_name = "recommender.load_test.model"
    @cli.save(model_name)
    assert_equal(@cli.load(model_name), true)
  end

  def test_get_status
    @cli.get_status
  end

end

