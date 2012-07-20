# This file is auto-generated from ../src/server/stat.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'

module Jubatus

class Config_data
  def to_msgpack(out = '')
    [@window_size].to_msgpack(out)
  end

  def from_unpacked(unpacked)
    @window_size = unpacked
  end



  attr_accessor :window_size
end

end
