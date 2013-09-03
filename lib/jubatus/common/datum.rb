module Jubatus
module Common

class Datum
  def initialize(string_values, num_values)
     @string_values = string_values 
     @num_values = num_values 
  end
  def to_tuple
    [
     @string_values.map {|x|  [x[0], x[1], ] },
     @num_values.map {|x|  [x[0], x[1], ] }
    ]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Datum.from_tuple(tuple)
    Datum.new(
      tuple[0].map {|x|  [x[0], x[1], ] },
      tuple[1].map {|x|  [x[0], x[1], ] }
    )
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
