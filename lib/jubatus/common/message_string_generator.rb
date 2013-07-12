module Jubatus
module Common

class MessageStringGenerator
  OPEN = "{"
  COLON = ": "
  DELIMITER = ", "
  CLOSE = "}"

  def initialize()
    @buf = []
    @first = true
  end

  def open(typ)
    @buf << typ.to_s
    @buf << OPEN
  end

  def add(key, value)
    if @first
      @first = false
    else
      @buf << DELIMITER
    end
    @buf << key.to_s
    @buf << COLON
    @buf << value.to_s
  end

  def close
    @buf << CLOSE
  end

  def to_s
    @buf.join
  end
end

end
end
