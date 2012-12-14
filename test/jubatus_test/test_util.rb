#!/usr/bin/env ruby

require 'rubygems'
require 'msgpack/rpc'

class TestUtil
    def self.wait_server(port)
        cli = MessagePack::RPC::Client.new("127.0.0.1", port)
        sleep_time = 1000;
        # 1000 * \sum {i=0..9} 2^i = 1024000 micro sec = 1024 ms
        for i in 0..9
            sleep(sleep_time/1000000.0) # from usec to sec
            begin
                cli.call("dummy")
                raise "dummy rpc succeeded"
            rescue MessagePack::RPC::RPCError => ex
                return if ex.class == MessagePack::RPC::RemoteError
            end
            sleep_time *= 2;
        end
        raise "cannot connect"
    end

    def self.fork_process(name, port = 9199, config = "")
        cmd = "juba" + name
        child = Process.fork()
        if child.nil? then
            begin
                exec(cmd, cmd, "--rpc-port", port.to_s, "--config", config, "--thread", "100", "--tmpdir", ".")
            rescue
                puts $!
                exit 1
            end
        end
        wait_server(port)
        return child;
    end

    def self.kill_process(pid)
        Process.kill("TERM", pid)
        Process.wait(pid)
    end

    def self.write_file(path, data)
        f = File.open(path, "w")
        f.write(data)
        f.close
    end
end
