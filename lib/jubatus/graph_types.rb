# This file is auto-generated from ../src/server/graph.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'

module Jubatus

class Node_info
  def to_msgpack(out = '')
    [@p, @in_edges, @out_edges].to_msgpack(out)
  end

  def from_unpacked(unpacked)
    @p, @in_edges, @out_edges = unpacked
  end

  def p=(val)
    @p = Property.new
    @p.from_unpacked(val)
  end

  attr_reader :p
  attr_accessor :in_edges, :out_edges
end

class Preset_query
  def to_msgpack(out = '')
    [@edge_query, @node_query].to_msgpack(out)
  end

  def from_unpacked(unpacked)
    @edge_query, @node_query = unpacked
  end



  attr_accessor :edge_query, :node_query
end

class Edge_info
  def to_msgpack(out = '')
    [@p, @src, @tgt].to_msgpack(out)
  end

  def from_unpacked(unpacked)
    @p, @src, @tgt = unpacked
  end

  def p=(val)
    @p = Property.new
    @p.from_unpacked(val)
  end

  attr_reader :p
  attr_accessor :src, :tgt
end

class Shortest_path_req
  def to_msgpack(out = '')
    [@src, @tgt, @max_hop, @q].to_msgpack(out)
  end

  def from_unpacked(unpacked)
    @src, @tgt, @max_hop, @q = unpacked
  end

  def q=(val)
    @q = Preset_query.new
    @q.from_unpacked(val)
  end

  attr_reader :q
  attr_accessor :src, :tgt, :max_hop
end

end
