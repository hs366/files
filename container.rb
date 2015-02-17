#!/usr/bin/ruby

require 'mcollective'
require 'json'
require 'awesome_print'

include MCollective::RPC


mc = rpcclient("docker")
mc.progress = true
mc.discover :nodes => ["eselivm2v882l"]

=begin

config = {
  :Hostname => "492510dd38e4",
  :Domainname => "",
  :User => "",
  :Memory => 0,
  :MemorySwap => 0,
  :CpuShares => 512,
  :Cpuset => "0,1",
  :AttachStdin => false,
  :AttachStdout => true,
  :AttachStderr => true,
  :PortSpecs => nil,
  :Tty => false,
  :OpenStdin => false,
  :StdinOnce => false,
  :Env => nil,
  :Cmd => ["echo 123"],
  :Image => "c4ff7513909dedf4ddf3a450aea68cd817c42e698ebccf54755973576525c416",
  :Volumes => {"/tmp" => {} },
  :WorkingDir => "",
  :NetworkDisabled => false,
  :ExposedPorts => {"22/tcp" => {} },
  :RestartPolicy => { "elegant_hypatia" => "always" }
}
=end

config ='{
  "Hostname":"492510dd38e4",
  "Image":"c4ff7513909dedf4ddf3a450aea68cd817c42e698ebccf54755973576525c416",
  "Cmd":"date"
}'
=begin

puts JSON.parse([ 'foo' ].to_json).first

=begin
config = '{
  \"Hostname\": \"492510dd38e\",
  \"Image\": \"c4ff7513909dedf4ddf3a450aea68cd817c42e698ebccf54755973576525c416\",
  \"Cmd\": \"date\",
}'
=end

#rpc_res = mc.createcontainer(:name => "ubuntu" , :config => JSON.generate([config]))
rpc_res = mc.createcontainer(:name => "ubuntu" , :config => config.to_json)

rpc_res.each do |rpc_obj|
 result = rpc_obj.results || {}


#    ap JSON.parse(result[:data][:details])
#    puts result[:data][:id]

 puts result.inspect
 puts result[:data][:id]
end




printrpcstats
mc.disconnect
