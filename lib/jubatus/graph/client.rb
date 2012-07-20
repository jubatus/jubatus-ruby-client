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
# This file is auto-generated from ./jubatus/jubatus.github/src/server//graph.idl
# *** DO NOT EDIT ***

require 'rubygems'
require 'msgpack/rpc'
require File.join(File.dirname(__FILE__), 'types')

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
    Node_info.from_tuple(@cli.call(:get_node, name, nid))
  end
  def get_edge(name, nid, e)
    Edge_info.from_tuple(@cli.call(:get_edge, name, nid, e))
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
