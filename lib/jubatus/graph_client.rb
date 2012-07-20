# This file is auto-generated from ../src/server/graph.idl
# *** DO NOT EDIT ***

require 'msgpack/rpc'
require './graph_types'

module Jubatus
module Client

class Graph
  def initialize(host, port)
    @cli = MessagePack::RPC::Client.new(host, port)
  end
  def create_node(name)
    @cli.call(:create_node, name)
  end
  def remove_node(name, nid)
    @cli.call(:remove_node, name, nid)
  end
  def update_node(name, nid, p)
    @cli.call(:update_node, name, nid, p)
  end
  def create_edge(name, nid, ei)
    @cli.call(:create_edge, name, nid, ei)
  end
  def update_edge(name, nid, eid, ei)
    @cli.call(:update_edge, name, nid, eid, ei)
  end
  def remove_edge(name, nid, e)
    @cli.call(:remove_edge, name, nid, e)
  end
  def centrality(name, nid, ct, q)
    @cli.call(:centrality, name, nid, ct, q)
  end
  def add_centrality_query(name, q)
    @cli.call(:add_centrality_query, name, q)
  end
  def add_shortest_path_query(name, q)
    @cli.call(:add_shortest_path_query, name, q)
  end
  def remove_centrality_query(name, q)
    @cli.call(:remove_centrality_query, name, q)
  end
  def remove_shortest_path_query(name, q)
    @cli.call(:remove_shortest_path_query, name, q)
  end
  def shortest_path(name, r)
    @cli.call(:shortest_path, name, r)
  end
  def update_index(name)
    @cli.call(:update_index, name)
  end
  def clear(name)
    @cli.call(:clear, name)
  end
  def get_node(name, nid)
    v = Node_info.new
    v.from_unpacked(@cli.call(:get_node, name, nid))
    return v
  end
  def get_edge(name, nid, e)
    v = Edge_info.new
    v.from_unpacked(@cli.call(:get_edge, name, nid, e))
    return v
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
  def create_node_here(name, nid)
    @cli.call(:create_node_here, name, nid)
  end
  def create_global_node(name, nid)
    @cli.call(:create_global_node, name, nid)
  end
  def remove_global_node(name, nid)
    @cli.call(:remove_global_node, name, nid)
  end
  def create_edge_here(name, eid, ei)
    @cli.call(:create_edge_here, name, eid, ei)
  end
end

end
end
