require 'test/unit'
require 'jubatus/common'
require 'msgpack'

module Jubatus
module Common

class DatumTest < Test::Unit::TestCase
  def test_pack
    assert_equal([[["name", "Taro"]], [["age", 20.0]], []].to_msgpack,
                 Datum.new({name: "Taro", "age" => 20}).to_msgpack.to_msgpack)
  end

  def test_unpack
    d = Datum.from_msgpack([[["name", "Taro"]], [["age", 20.0]], [["img", "0101"]]])
    assert_equal([["name", "Taro"]],
                 d.string_values)
    assert_equal([["age", 20.0]],
                 d.num_values)
    assert_equal([["img", "0101"]],
                 d.binary_values)
  end

  def test_add_string
    d = Datum.new
    d.add_string("key", "value")
    assert_equal([["key", "value"]], d.string_values)
  end

  def test_add_number
    d = Datum.new
    d.add_number("key", 20.0)
    assert_equal([["key", 20.0]], d.num_values)
  end

  def test_add_binary
    d = Datum.new
    d.add_binary("key", "0101")
    assert_equal([["key", "0101"]], d.binary_values)
  end

  def test_empty
    assert_equal([[], [], []].to_msgpack,
                 Datum.new.to_msgpack.to_msgpack)
  end

  def test_invalid_key
    assert_raise(TypeError) {
      Datum.new(1 => "")
    }
  end

  def test_invalid_value
    assert_raise(TypeError) { Datum.new("" => nil) }
    assert_raise(TypeError) { Datum.new("" => []) }
  end

end

end
end
