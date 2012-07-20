# This file is auto-generated from ../src/server/regression.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'
require './regression_types'

module Jubatus
module Client

class Regression
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
  def train(name, train_data)
    @cli.call(:train, name, train_data)
  end
  def estimate(name, estimate_data)
    @cli.call(:estimate, name, estimate_data)
  end
  def save(name, arg1)
    @cli.call(:save, name, arg1)
  end
  def load(name, arg1)
    @cli.call(:load, name, arg1)
  end
  def get_status(name)
    @cli.call(:get_status, name)
  end
end

end
end
