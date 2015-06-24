#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/nearest_neighbor/client'
require 'jubatus_test/test_util'

class NearestNeighborTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23007
  TIMEOUT = 10

  def setup
    @config = {
      "method" => "lsh",
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
        "hash_num" => 64
      }
    }

    TestUtil.write_file("config_nearest_neighbor.json", @config.to_json)
    @srv = TestUtil.fork_process("nearest_neighbor", PORT, "config_nearest_neighbor.json")
    @cli = Jubatus::NearestNeighbor::Client::NearestNeighbor.new(HOST, PORT, "name")
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

  def test_neighbor_row
    @cli.clear
    d = Jubatus::Common::Datum.new("skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0)
    @cli.set_row("neighbor_row", d)
    d1 = @cli.neighbor_row_from_id("neighbor_row", 10)
    d2 = @cli.neighbor_row_from_datum(d, 10)
  end

  def test_similar_row
    @cli.clear
    d = Jubatus::Common::Datum.new("skey1" => "val1", "skey2" => "val2", "nkey1" => 1.0, "nkey2" => 2.0)
    @cli.set_row("similar_row", d)
    s1 = @cli.similar_row_from_id("similar_row", 10)
    s2 = @cli.similar_row_from_datum(d, 10)
  end

  def test_clear
    @cli.clear
  end

  def test_save
    assert_equal(@cli.save("nearest_neighbor.save_test.model").size, 1)
  end

  def test_load
    model_name = "nearest_neighbor.load_test.model"
    @cli.save(model_name)
    assert_equal(@cli.load(model_name), true)
  end

  def test_get_status
    @cli.get_status
  end

end

