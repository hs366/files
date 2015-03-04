#!/usr/bin/ruby

require 'mcollective'
require 'json'
require 'awesome_print'

include MCollective::RPC

mc = rpcclient("docker")
mc.progress = true
mc.discover :nodes => ["host1"]

config ='{"Image": "ubuntu", "Cmd": "date"}'

#puts JSON.parse([ 'foo' ].to_json).first
#rpc_res = mc.createcontainer(:name => "ubuntu" , :config => JSON.generate([config]))

rpc_res = mc.createcontainer(:name => "test1234" , :config => config)
rpc_res.each do |rpc_obj|
 result = rpc_obj.results || {}
 puts result.inspect
 puts result[:data][:id]
end


printrpcstats
mc.disconnect
