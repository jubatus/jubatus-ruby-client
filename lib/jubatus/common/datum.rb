require 'jubatus/common'
module Jubatus
module Common

class Datum
  include Jubatus::Common
  TYPE = TTuple.new(TList.new(TTuple.new(TString.new, TString.new)),
                    TList.new(TTuple.new(TString.new, TFloat.new)))
  def initialize(string_values, num_values)
     @string_values = string_values 
     @num_values = num_values 
  end
  def to_msgpack(out = '')
    t = [@string_values, @num_values]
    return TYPE.to_msgpack(t)
  end
  def Datum.from_msgpack(m)
    val = TYPE.from_msgpack(m)
    Datum.new(*val)
  end
  def to_s
    gen = Jubatus::Common::MessageStringGenerator.new
    gen.open("datum")
    gen.add("string_values", @string_values)
    gen.add("num_values", @num_values)
    gen.close()
    return gen.to_s
  end
  attr_accessor :string_values, :num_values
end

end
end
