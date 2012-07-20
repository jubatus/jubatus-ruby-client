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

class String
  def to_tuple
    self
  end
end

class Hash
  def to_tuple
    self
  end
end

module Jubatus

class Property
  def Property.from_tuple(tuple)
    tuple.each_with_object({}) {|(k,v),h| h[k] = v }
  end
  def to_tuple(o)
    o
  end
end

class Node_info
  def initialize(p, in_edges, out_edges)
     @p = p 
     @in_edges = in_edges 
     @out_edges = out_edges 
  end
  def to_tuple    
    [@p.to_tuple,
     @in_edges.map {|x| x},
     @out_edges.map {|x| x}]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Node_info.from_tuple(tuple)
    Node_info.new(
      Property.from_tuple(tuple[0]),
      tuple[1].map { |x| x },
      tuple[2].map { |x| x }
    )
  end
  attr_reader :p
  attr_accessor :in_edges, :out_edges
end

class Preset_query
  def initialize(edge_query, node_query)
     @edge_query = edge_query 
     @node_query = node_query 
  end
  def to_tuple    
    [@edge_query.map {|x|  [x[0], x[1], ] },
     @node_query.map {|x|  [x[0], x[1], ] }]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Preset_query.from_tuple(tuple)
    Preset_query.new(
      tuple[0].map { |x|  [x[0] , x[1] ]  },
      tuple[1].map { |x|  [x[0] , x[1] ]  }
    )
  end
  attr_accessor :edge_query, :node_query
end

class Edge_info
  def initialize(p, src, tgt)
     @p = p 
     @src = src 
     @tgt = tgt 
  end
  def to_tuple    
    [@p.to_tuple,
     @src,
     @tgt]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Edge_info.from_tuple(tuple)
    Edge_info.new(
      Property.from_tuple(tuple[0]),
      tuple[1],
      tuple[2]
    )
  end
  attr_reader :p
  attr_accessor :src, :tgt
end

class Shortest_path_req
  def initialize(src, tgt, max_hop, q)
     @src = src 
     @tgt = tgt 
     @max_hop = max_hop 
     @q = q 
  end
  def to_tuple    
    [@src,
     @tgt,
     @max_hop,
     @q.to_tuple]
  end
  def to_msgpack(out = '')
    to_tuple.to_msgpack(out)
  end
  def Shortest_path_req.from_tuple(tuple)
    Shortest_path_req.new(
      tuple[0],
      tuple[1],
      tuple[2],
      Preset_query.from_tuple(tuple[3])
    )
  end
  attr_reader :q
  attr_accessor :src, :tgt, :max_hop
end

end

