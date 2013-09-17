require 'test/unit'
require 'jubatus/common'
require 'msgpack'

module Jubatus
module Common

class DatumTest < Test::Unit::TestCase
  def test_pack
    assert_equal([[["name", "Taro"]], [["age", 20.0]], []].to_msgpack,
                 Datum.new({"name" => "Taro", "age" => 20}).to_msgpack.to_msgpack)
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

  def test_empty
    assert_equal([[], [], []].to_msgpack,
                 Datum.new.to_msgpack.to_msgpack)
  end

  def test_invalid_key
    assert_raise(TypeError) {
      Datum.new({1 => ""})
    }
  end

  def test_invalid_value
    assert_raise(TypeError) { Datum.new({"" => nil}) }
    assert_raise(TypeError) { Datum.new({"" => []}) }
  end

end

end
end
