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
# This file is auto-generated from ./jubatus/jubatus.github/src/server//recommender.idl
# *** DO NOT EDIT ***

require 'rubygems'
require 'msgpack/rpc'
require File.join(File.dirname(__FILE__), 'types')

module Jubatus
module Client

class Recommender
  def initialize(host, port)
    @cli = MessagePack::RPC::Client.new(host, port)
  end
  def set_config(name, c)
    @cli.call(:set_config, name, c)
  end
  def get_config(name)
    Config_data.from_tuple(@cli.call(:get_config, name))
  end
  def clear_row(name, id)
    @cli.call(:clear_row, name, id)
  end
  def update_row(name, id, d)
    @cli.call(:update_row, name, id, d)
  end
  def clear(name)
    @cli.call(:clear, name)
  end
  def complete_row_from_id(name, id)
    Datum.from_tuple(@cli.call(:complete_row_from_id, name, id))
  end
  def complete_row_from_data(name, d)
    Datum.from_tuple(@cli.call(:complete_row_from_data, name, d))
  end
  def similar_row_from_id(name, id, size)
    Similar_result.from_tuple(@cli.call(:similar_row_from_id, name, id, size))
  end
  def similar_row_from_data(name, data, size)
    Similar_result.from_tuple(@cli.call(:similar_row_from_data, name, data, size))
  end
  def decode_row(name, id)
    Datum.from_tuple(@cli.call(:decode_row, name, id))
  end
  def get_all_rows(name)
    @cli.call(:get_all_rows, name)
  end
  def similarity(name, lhs, rhs)
    @cli.call(:similarity, name, lhs, rhs)
  end
  def l2norm(name, d)
    @cli.call(:l2norm, name, d)
  end
  def save(name, id)
    @cli.call(:save, name, id)
  end
  def load(name, id)
    @cli.call(:load, name, id)
  end
  def get_status(name)
    @cli.call(:get_status, name)
  end
end

end
end
