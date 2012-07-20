# This file is auto-generated from ../src/server/classifier.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'
require './classifier_types'

module Jubatus
module Client

class Classifier
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
  def train(name, data)
    @cli.call(:train, name, data)
  end
  def classify(name, data)
    @cli.call(:classify, name, data)
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
