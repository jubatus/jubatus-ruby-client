#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus/common/message_string_generator'

module Jubatus
module Common

class MessageStringGeneratorTest < Test::Unit::TestCase

  def test_empty
    gen = MessageStringGenerator.new
    gen.open("test")
    gen.close

    assert_equal("test{}", gen.to_s)
  end

  def test_one
    gen = MessageStringGenerator.new
    gen.open("test")
    gen.add("k1", "v1")
    gen.close

    assert_equal("test{k1: v1}", gen.to_s)
  end

  def test_two
    gen = MessageStringGenerator.new
    gen.open("test")
    gen.add("k1", "v1")
    gen.add("k2", "v2")
    gen.close

    assert_equal("test{k1: v1, k2: v2}", gen.to_s)
  end

  def test_number
    gen = MessageStringGenerator.new
    gen.open("test")
    gen.add("k1", 1)
    gen.close

    assert_equal("test{k1: 1}", gen.to_s)
  end

end

end
end
