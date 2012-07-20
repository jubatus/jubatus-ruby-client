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
require File.join(File.dirname(__FILE__), 'types')

module Jubatus
module Client

class Stat
  def initialize(host, port)
    @cli = MessagePack::RPC::Client.new(host, port)
  end
  def set_config(name, c)
    @cli.call(:set_config, name, c)
  end
  def get_config(name)
    Config_data.from_tuple(@cli.call(:get_config, name))
  end
  def push(name, key, val)
    @cli.call(:push, name, key, val)
  end
  def sum(name, key)
    @cli.call(:sum, name, key)
  end
  def stddev(name, key)
    @cli.call(:stddev, name, key)
  end
  def max(name, key)
    @cli.call(:max, name, key)
  end
  def min(name, key)
    @cli.call(:min, name, key)
  end
  def entropy(name, key)
    @cli.call(:entropy, name, key)
  end
  def moment(name, key, n, c)
    @cli.call(:moment, name, key, n, c)
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
