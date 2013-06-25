module Jubatus
module Common

class TypeError < Exception; end
class ValueError < Exception; end

def self.check_type(value, typ)
  if not (typ === value)
    raise TypeError, "type %s is expected, but %s is given" % [typ, value.class]
  end
end

def self.check_types(value, types)
  types.each do |t|
    return if t === value
  end
  t = types.map { |t| t.to_s }.join(", ")
  raise TypeError, "type %s is expected, but %s is given" % [t, value.class]
end

class TPrimitive
  def initialize(types)
    @types = types
  end

  def from_msgpack(m)
    Jubatus::Common.check_types(m, @types)
    return m
  end

  def to_msgpack(m)
    Jubatus::Common.check_types(m, @types)
    return m
  end
end

class TInt < TPrimitive
  def initialize(signed, bits)
    if signed
      @max = (1 << (bits - 1)) - 1
      @min = - (1 << (bits - 1))
    else
      @max = (1 << bits) - 1
      @min = 0
    end
  end

  def from_msgpack(m)
    Jubatus::Common.check_type(m, Integer)
    if not (@min <= m and m <= @max)
      raise ValueError
    end
    return m
  end

  def to_msgpack(m)
    Jubatus::Common.check_type(m, Integer)
    if not (@min <= m and m <= @max)
      raise ValueError
    end
    return m
  end
end

class TFloat < TPrimitive
  def initialize
    super([Float])
  end
end

class TBool < TPrimitive
  def initialize
    super([TrueClass, FalseClass])
  end
end

class TString < TPrimitive
  def initialize()
    super([String])
  end
end

class TRaw < TPrimitive
  def initialize()
    super([String])
  end
end

class TNullable
  def initialize(type)
    @type = type
  end

  def from_msgpack(m)
    if m.nil?
      return nil
    else
      @type.from_msgpack(m)
    end
  end

  def to_msgpack(m)
    if m.nil?
      nil
    else
      @type.to_msgpack(m)
    end
  end
end

class TList
  def initialize(type)
    @type = type
  end

  def from_msgpack(m)
    Jubatus::Common.check_type(m, Array)
    return m.map { |v| @type.from_msgpack(v) }
  end

  def to_msgpack(m)
    Jubatus::Common.check_type(m, Array)
    return m.map { |v| @type.to_msgpack(v) }
  end
end

class TMap
  def initialize(key, value)
    @key = key
    @value = value
  end

  def from_msgpack(m)
    Jubatus::Common.check_type(m, Hash)
    dic = {}
    m.each do |k, v|
      dic[@key.from_msgpack(k)] = @value.from_msgpack(v)
    end
    return dic
  end

  def to_msgpack(m)
    Jubatus::Common.check_type(m, dict)
    dic = {}
    m.each do |k, v|
      dic[@key.to_msgpack(k)] = @value.to_msgpack(v)
    end
    return dic
  end
end

class TTuple
  def initialize(*types)
    @types = types
  end

  def check_tuple(m)
    Jubatus::Common.check_type(m, Array)
    if m.size != @types.size
      raise TypeError, "size of tuple is %d, but %d is expected: %s" % [m.size, @types.size, m.to_s]
    end
  end

  def from_msgpack(m)
    check_tuple(m)
    tpl = []
    @types.zip(m).each do |type, x|
      tpl << type.from_msgpack(x)
    end
    return tpl
  end

  def to_msgpack(m)
    check_tuple(m)
    tpl = []
    @types.zip(m).each do |type, x|
      tpl << type.to_msgpack(x)
    end
    return tpl
  end
end

class TUserDef
  def initialize(type)
    @type = type
  end

  def from_msgpack(m)
    return @type.from_msgpack(m)
  end

  def to_msgpack(m)
    Jubatus::Common.check_type(m, @type)
    return m.to_msgpack()
  end
end

class TObject
  def from_msgpack(m)
    return m
  end

  def to_msgpack(m)
    return m
  end
end

class TEnum
  def initialize(values)
    @values = values
  end

  def from_msgpack(m)
    Jubatus::Common.check_type(m, Integer)
    if not (@values.include?(m))
      raise ValueError
    end
    return m
  end

  def to_msgpack(m)
    Jubatus::Common.check_type(m, Integer)
    if not (@values.inlcude?(m))
      raise ValueError
    end
    return m
  end
end

end
end
