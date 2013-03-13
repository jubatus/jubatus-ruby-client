#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/anomaly/client'
require 'jubatus/anomaly/types'
require 'jubatus_test/test_util'

class AnomalyTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23006
  TIMEOUT = 10

  def setup
    @config = {
     "method" => "lof",
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
       "nearest_neighbor_num" => 10,
       "reverse_nearest_neighbor_num" => 30,
       "method" => "euclid_lsh",
       "parameter" => {
         "lsh_num" => 8,
         "table_num" => 16,
         "probe_num" => 64,
         "bin_width" => 10.0,
         "seed" => 1091,
         "retain_projection" => false
       }
     }
    }

    TestUtil.write_file("config_anomaly.json", @config.to_json)
    @srv = TestUtil.fork_process("anomaly", PORT, "config_anomaly.json")
    @cli = Jubatus::Anomaly::Client::Anomaly.new(HOST, PORT)
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_client
    assert_instance_of( MessagePack::RPC::Client, @cli.get_client )
  end

  def test_clear_row
    d = Jubatus::Anomaly::Datum.new([], [])
    (row_id, score) = @cli.add("name", d)
    assert_equal(true, @cli.clear_row("name", row_id))
  end

  def test_add
    d = Jubatus::Anomaly::Datum.new([], [])
    (row_id, score) = @cli.add("name", d)
  end

  def test_update
    d = Jubatus::Anomaly::Datum.new([], [])
    (row_id, score) = @cli.add("name", d)
    d = Jubatus::Anomaly::Datum.new([], [['val', 3.1]])
    score = @cli.update("name", row_id, d)
  end

  def test_clear
    assert_equal(true, @cli.clear("name"))
  end

  def test_calc_score
    d = Jubatus::Anomaly::Datum.new([], [['val', 1.1]])
    (row_id, score) = @cli.add("name", d)
    d = Jubatus::Anomaly::Datum.new([], [['val', 3.1]])
    score = @cli.calc_score("name", d)
  end

  def test_get_all_rows
    @cli.get_all_rows("name")
  end

  def test_get_config
    config = @cli.get_config("name")
    assert_equal(JSON.parse(config), @config)
  end

  def test_save
    assert_equal(true, @cli.save("name", "anomaly.save_test.model"))
  end

  def test_load
    model_name = "anomaly.load_test.model"
    @cli.save("name", model_name)
    assert_equal(true, @cli.load("name", model_name))
  end

  def test_get_status
    @cli.get_status("name")
  end

end
