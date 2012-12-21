#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus_test/test_util'

require 'jubatus/graph/client'
require 'jubatus/graph/types'

class GraphTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23005
  TIMEOUT = 10

  def setup
    @srv = TestUtil.fork_process("graph", PORT)
    @cli = Jubatus::Client::Graph.new(HOST, PORT)
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_node_info
    edge_query = [["a", "b"], ["c", "d"], ["e", "f"]]
    node_query = [["0", "1"], ["2", "3"]]
    p = Jubatus::Preset_query.new(edge_query, node_query)
    in_edges = [0, 0]
    out_edges = [0, 0]
    Jubatus::Node_info.new(p, in_edges, out_edges)
  end


  def test_create_node
    name = "name"
    @cli.clear(name)
    nid = @cli.create_node("sample_node")
    assert_equal(nid.to_i.to_s, nid)
  end

  def test_remove_node
    name = "name"
    @cli.clear(name)
    nid = @cli.create_node(name)
    assert_equal(@cli.remove_node(name, nid), True)

  end


  def test_update_node
    name = "name"
    @cli.clear(name)
    nid = @cli.create_node(name)
    prop = {"key1" => "val1", "key2" => "val2"}
    assert_equal(@cli.update_node(name, nid, prop), True)
  end


  def test_create_edge
    name = "name"
    @cli.clear(name)
    src = @cli.create_node(name)
    tgt = @cli.create_node(name)
    prop = {"key1" => "val1", "key2" => "val2"}
    ei = Jubatus::Edge_info.new(prop, src, tgt)
    eid = @cli.create_edge("name", tgt, ei)
  end


  def test_create_edge
    name = "name"
    @cli.clear(name)
    src = @cli.create_node(name)
    tgt = @cli.create_node(name)
    prop = {"key1" => "val1", "key2" => "val2"}
    ei = Jubatus::Edge_info.new(prop, src, tgt)
    eid = @cli.create_edge(src, tgt, ei)
  end
end

