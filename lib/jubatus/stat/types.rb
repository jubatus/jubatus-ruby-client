# 
# Copyright (c) 2012 Preferred Infrastructure, inc.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# This file is auto-generated from ./jubatus/jubatus.github/src/server//stat.idl
# *** DO NOT EDIT ***

require 'rubygems'
require 'msgpack/rpc'
module Jubatus

class Config_data
  def initialize(window_size)
     @window_size = window_size 
  end
  def to_tuple    
    [@window_size]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Config_data.from_tuple(tuple)
    Config_data.new(
      tuple[0]
    )
  end
  attr_accessor :window_size
end

end

