# This file is auto-generated from ../src/server/recommender.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'
require './recommender_types'

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
    v = Config_data.new
    v.from_unpacked(@cli.call(:get_config, name))
    return v
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
    v = Datum.new
    v.from_unpacked(@cli.call(:complete_row_from_id, name, id))
    return v
  end
  def complete_row_from_data(name, d)
    v = Datum.new
    v.from_unpacked(@cli.call(:complete_row_from_data, name, d))
    return v
  end
  def similar_row_from_id(name, id, size)
    v = Similar_result.new
    v.from_unpacked(@cli.call(:similar_row_from_id, name, id, size))
    return v
  end
  def similar_row_from_data(name, data, size)
    v = Similar_result.new
    v.from_unpacked(@cli.call(:similar_row_from_data, name, data, size))
    return v
  end
  def decode_row(name, id)
    v = Datum.new
    v.from_unpacked(@cli.call(:decode_row, name, id))
    return v
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
