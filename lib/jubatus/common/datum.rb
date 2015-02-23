require 'jubatus/common'
module Jubatus
module Common

class Datum
  include Jubatus::Common
  TYPE = TTuple.new(TList.new(TTuple.new(TString.new, TString.new)),
                    TList.new(TTuple.new(TString.new, TFloat.new)),
                    TList.new(TTuple.new(TString.new, TString.new)))

  def initialize(values = {})
    @string_values = []
    @num_values = []
    @binary_values = []
    values.each { |key, v|
      raise TypeError unless String === key || Symbol === key
      k = key.to_s
      if String === v
        @string_values << [k, v]
      elsif Integer === v
        @num_values << [k, v.to_f]
      elsif Float === v
        @num_values << [k, v]
      else
        raise TypeError
      end
    }
  end

  def add_string(key, value)
    raise TypeError unless String === key
    if String === value
      @string_values << [key, value]
    else
      raise TypeError
    end
  end

  def add_number(key, value)
    raise TypeError unless String === key
    if Integer === value
      @num_values << [key, value.to_f]
    elsif Float === value
      @num_values << [key, value]
    else
      raise TypeError
    end
  end

  def add_binary(key, value)
    raise TypeError unless String === key
    if String === value
      @binary_values << [key, value]
    else
      raise TypeError
    end
  end

  def to_msgpack(out = '')
    t = [@string_values, @num_values, @binary_values]
    return TYPE.to_msgpack(t)
  end

  def Datum.from_msgpack(m)
    val = TYPE.from_msgpack(m)
    d = Datum.new
    d.string_values.concat(m[0])
    d.num_values.concat(m[1])
    d.binary_values.concat(m[2])
    return d
  end

  def to_s
    gen = Jubatus::Common::MessageStringGenerator.new
    gen.open("datum")
    gen.add("string_values", @string_values)
    gen.add("num_values", @num_values)
    gen.add("binary_values", @binary_values)
    gen.close()
    return gen.to_s
  end
  attr_reader :string_values, :num_values, :binary_values
end

end
end
