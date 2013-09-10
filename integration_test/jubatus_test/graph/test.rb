#!/usr/bin/env ruby

require 'test/unit'
require 'jubatus_test/test_util'

require 'json'

require 'jubatus/graph/client'
require 'jubatus/graph/types'

class GraphTest < Test::Unit::TestCase
  HOST = "127.0.0.1"
  PORT = 23005
  TIMEOUT = 10

  def setup
    @config = {
      "method" => "graph_wo_index",
      "parameter" => {
           "damping_factor" => 0.9,
           "landmark_num" => 5
      }
    }

    TestUtil.write_file("config_graph.json", @config.to_json)
    @srv = TestUtil.fork_process("graph", PORT, "config_graph.json")
    @cli = Jubatus::Graph::Client::Graph.new(HOST, PORT, "name")
  end

  def teardown
    TestUtil.kill_process(@srv)
  end

  def test_get_client
    assert_instance_of( MessagePack::RPC::Client, @cli.get_client )
  end

  def test_node_info
    edge_query = [["a", "b"], ["c", "d"], ["e", "f"]]
    node_query = [["0", "1"], ["2", "3"]]
    p = Jubatus::Graph::Preset_query.new(edge_query, node_query)
    in_edges = [0, 0]
    out_edges = [0, 0]
    Jubatus::Graph::Node.new(p, in_edges, out_edges)
  end

  def test_create_node
    @cli.clear
    nid = @cli.create_node
    assert_equal(nid.to_i.to_s, nid)
  end

  def test_remove_node
    @cli.clear
    nid = @cli.create_node
    assert_equal(@cli.remove_node(nid), true)
  end

  def test_update_node
    @cli.clear
    nid = @cli.create_node
    prop = {"key1" => "val1", "key2" => "val2"}
    assert_equal(@cli.update_node(nid, prop), true)
  end

  def test_create_edge
    @cli.clear
    src = @cli.create_node
    tgt = @cli.create_node
    prop = {"key1" => "val1", "key2" => "val2"}
    ei = Jubatus::Graph::Edge.new(prop, src, tgt)
    eid = @cli.create_edge(tgt, ei)
  end

  def test_get_config
    config = @cli.get_config
    assert_equal(JSON.parse(config), @config)
  end

end

