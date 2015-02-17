#!/usr/bin/ruby

require 'mcollective'
require 'json'
require 'awesome_print'

include MCollective::RPC


mc = rpcclient("docker")
mc.progress = true
mc.discover :nodes => ["host1"]

#rpc_res = mc.images(:all => false)
#rpc_res = mc.history(:name => "c4ff7513909d")
#rpc_res = mc.inspectimage(:name => "c4ff7513909d")
#rpc_res = mc.info()
#rpc_res = mc.containers(:all => true)
#rpc_res = mc.inspectcontainer(:id => "4fb22515a13ee26ad5252d2819022604d9f57453c5aebb32e4a266cfaa00a38a")
#rpc_res = mc.restart(:id => "4fb22515a13ee26ad5252d2819022604d9f57453c5aebb32e4a266cfaa00a38a", :timeout => 7 )
#rpc_res = mc.kill(:id =>  "4fb22515a13e")
#rpc_res = mc.createimage(:repo => "centos", :tag => "latest", :fromimage => "centos")
#rpc_res = mc.version()

rpc_res = mc.events(:since => 1423710464, :until => 1423752881)
rpc_res.each do |rpc_obj|
 result = rpc_obj.results || {}



#    ap JSON.parse( result [:data][:images])
#    puts result [:data][:history]
#    ap JSON.parse( result [:data][:details])
#    puts result[:data]
#    ap JSON.parse (result [:data][:containers])
#    ap JSON.parse(result[:data][:details])
#    puts result[:data][:id]
#    puts [result.inspect]
#    ap JSON.parse(result[:data][:version])
#    puts result[:data][:version]
#    ap JSON.parse(result[:data][:info])



  puts result.inspect
  puts result[:data][:events]


end

printrpcstats
mc.disconnect
~
~
~
~
~
