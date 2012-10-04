#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus_test/test_util'

require 'jubatus/stat/client'
require 'jubatus/stat/types'

class StatTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23004
  TIMEOUT = 10

  def setup
    @srv = TestUtil.fork_process("stat", PORT)
    @cli = Jubatus::Client::Stat.new(HOST, PORT)
    @window_size = 10
    cd = Jubatus::Config_data.new(@window_size)
    @cli.set_config("name", cd)

  end


  def teardown
    TestUtil.kill_process(@srv)
  end


  def test_get_config
    config = @cli.get_config("name")
    assert_equal(config.window_size, @window_size)

  end


  def test_stddev
    @cli.push("name", "stddev", 1.0)
    @cli.push("name", "stddev", 2.0)
    @cli.push("name", "stddev", 3.0)
    @cli.push("name", "stddev", 4.0)
    @cli.push("name", "stddev", 5.0)
    assert_equal(@cli.stddev("name", "stddev"), Math::sqrt(2.0))

  end


  def test_sum
    @cli.push("name", "sum", 1.0)
    @cli.push("name", "sum", 2.0)
    @cli.push("name", "sum", 3.0)
    @cli.push("name", "sum", 4.0)
    @cli.push("name", "sum", 5.0)
    assert_equal(@cli.sum("name", "sum"), 15.0)

  end


  def test_max
    @cli.push("name", "max", 1.0)
    @cli.push("name", "max", 2.0)
    @cli.push("name", "max", 3.0)
    @cli.push("name", "max", 4.0)
    @cli.push("name", "max", 5.0)
    assert_equal(@cli.max("name", "max"), 5.0)

  end


  def test_min
    @cli.push("name", "min", 1.0)
    @cli.push("name", "min", 2.0)
    @cli.push("name", "min", 3.0)
    @cli.push("name", "min", 4.0)
    @cli.push("name", "min", 5.0)
    assert_equal(@cli.min("name", "min"), 1.0)

  end


  def test_entropy
    @cli.push("name", "entropy", 1.0)
    @cli.push("name", "entropy", 2.0)
    @cli.push("name", "entropy", 3.0)
    @cli.push("name", "entropy", 4.0)
    @cli.push("name", "entropy", 5.0)
    assert_equal(@cli.entropy("name", "entropy"), 0.0)

  end


  def test_moment
    @cli.push("name", "moment", 1.0)
    @cli.push("name", "moment", 2.0)
    @cli.push("name", "moment", 3.0)
    @cli.push("name", "moment", 4.0)
    @cli.push("name", "moment", 5.0)
    assert_equal(@cli.moment("name", "moment", 3, 0.0), 45.0)

  end


  def test_save
    assert_equal(@cli.save("name", "stat.save_test.model"), true)

  end


  def test_load
    model_name = "stat.load_test.model"
    @cli.save("name", model_name)
    assert_equal(@cli.load("name", model_name), true)

  end


  def test_get_status
    @cli.get_status("name")

  end


end

