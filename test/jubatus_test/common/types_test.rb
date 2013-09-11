#!/usr/bin/env ruby

require 'jubatus/common/types'
require 'test/unit'

module Jubatus
module Common

class TypeCheckTest < Test::Unit::TestCase
  def convert(type, value)
    return type.from_msgpack(value)
  end

  def assertTypeOf(type, value)
    assert_equal(value, convert(type, value))
  end

  def assertTypeError(type, value)
    assert_raise(TypeError) { convert(type, value) }
  end

  def assertValueError(type, value)
    assert_raise(ValueError) { convert(type, value) }
  end
    
  def testInt()
    assertTypeOf(TInt.new(true, 1), 1)
    assertTypeError(TInt.new(true, 1), nil)
    assertTypeError(TInt.new(true, 1), "")
    assertValueError(TInt.new(true, 1), 128)
    assertValueError(TInt.new(true, 1), -129)
    assertValueError(TInt.new(false, 1), 256)
    assertValueError(TInt.new(false, 1), -1)
  end

  def testFloat()
    assertTypeOf(TFloat.new(), 1.3)
    assertTypeError(TFloat.new(), nil)
    assertTypeError(TFloat.new(), 1)
  end

  def testBool()
    assertTypeOf(TBool.new(), true)
    assertTypeError(TBool.new(), nil)
    assertTypeError(TBool.new(), 1)
  end

  def testString()
    assertTypeOf(TString.new(), "test")
    assertTypeError(TString.new(), 1)
  end

  def testRaw()
    assertTypeOf(TRaw.new(), "test")
    assertTypeError(TRaw.new(), 1)
  end

  def testList()
    assertTypeOf(TList.new(TInt.new(true, 8)), [1, 2, 3])
    assertTypeOf(TList.new(TList.new(TInt.new(true, 8))), [[1, 2], [], [2, 3]])
    assertTypeError(TList.new(TInt.new(true, 8)), nil)
  end

  def testTuple()
    assertTypeOf(TTuple.new(TInt.new(true, 8), TTuple.new(TString.new(), TInt.new(true, 8))), [1, ["test", 1]])
    assertTypeError(TTuple.new(TInt.new(true, 8)), ["test"])
    assertTypeError(TTuple.new(TInt.new(true, 8)), [1, 2])
  end
end

end
end

