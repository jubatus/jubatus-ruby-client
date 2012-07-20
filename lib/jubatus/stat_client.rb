# This file is auto-generated from ../src/server/stat.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'
require './stat_types'

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
    v = Config_data.new
    v.from_unpacked(@cli.call(:get_config, name))
    return v
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
