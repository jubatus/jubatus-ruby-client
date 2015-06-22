#!/usr/bin/env ruby

require 'test/unit'

require 'json'

require 'jubatus/stat/client'
require 'jubatus_test/test_util'

class StatTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23004
  TIMEOUT = 10

  def setup
    @config = {
        "window_size" => 10
    }

    TestUtil.write_file("config_stat.json", @config.to_json)
    @srv = TestUtil.fork_process("stat", PORT, "config_stat.json")
    @cli = Jubatus::Stat::Client::Stat.new(HOST, PORT, "name")

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

  def test_stddev
    @cli.push("stddev", 1.0)
    @cli.push("stddev", 2.0)
    @cli.push("stddev", 3.0)
    @cli.push("stddev", 4.0)
    @cli.push("stddev", 5.0)
    assert_equal(@cli.stddev("stddev"), Math::sqrt(2.0))
  end

  def test_sum
    @cli.push("sum", 1.0)
    @cli.push("sum", 2.0)
    @cli.push("sum", 3.0)
    @cli.push("sum", 4.0)
    @cli.push("sum", 5.0)
    assert_equal(@cli.sum("sum"), 15.0)
  end

  def test_max
    @cli.push("max", 1.0)
    @cli.push("max", 2.0)
    @cli.push("max", 3.0)
    @cli.push("max", 4.0)
    @cli.push("max", 5.0)
    assert_equal(@cli.max("max"), 5.0)
  end

  def test_min
    @cli.push("min", 1.0)
    @cli.push("min", 2.0)
    @cli.push("min", 3.0)
    @cli.push("min", 4.0)
    @cli.push("min", 5.0)
    assert_equal(@cli.min("min"), 1.0)
  end

  def test_entropy
    @cli.push("entropy", 1.0)
    @cli.push("entropy", 2.0)
    @cli.push("entropy", 3.0)
    @cli.push("entropy", 4.0)
    @cli.push("entropy", 5.0)
    assert_equal(@cli.entropy("entropy"), 0.0)
  end

  def test_moment
    @cli.push("moment", 1.0)
    @cli.push("moment", 2.0)
    @cli.push("moment", 3.0)
    @cli.push("moment", 4.0)
    @cli.push("moment", 5.0)
    assert_equal(@cli.moment("moment", 3, 0.0), 45.0)
  end

  def test_save
    assert_equal(@cli.save("stat.save_test.model").size, 1)
  end

  def test_load
    model_name = "stat.load_test.model"
    @cli.save(model_name)
    assert_equal(@cli.load(model_name), true)
  end

  def test_get_status
    @cli.get_status
  end

end

