#!/usr/bin/ruby
require 'json'
require 'socket'
require 'excon'
require 'awesome_print'
require 'logger'

$logger = Logger.new($stdout)
$logger.level = Logger::DEBUG 

def _request(htmethod, endpoint, options = {}, body = "")
  rs = endpoint
  unless options == {}
    options.each {|r| rs += "&" + 
      URI.escape(r[0].to_s) + "=" + 
      URI.escape(r[1].to_s) }
  end
  $logger.debug("docker/_request htmethod=#{htmethod} endpint=#{endpoint}, request=unix:///#{rs}, body=#{body}")

  case htmethod
  when :get
    response = Excon.get("unix:///#{rs}", :socket => '/var/run/docker.sock')
  when :post
    response = Excon.post("unix:///#{rs}", 
                          :socket => '/var/run/docker.sock', 
                          :body => body, 
                          :headers => {"Content-Type" => "application/json"})
  when :delete
    response = Excon.delete("unix:///#{rs}", 
                            :socket => '/var/run/docker.sock', 
                            :body => body, 
                            :headers => {"Content-Type" => "application/json"})
  else
    raise "Internal error"
  end
  
 case response.status
  when 200
    return response.status
  when 201
    return response.body
  when 204
    return response.body
  else
    raise "Unable to fulfill request. HTTP status #{response.status}"
  end
end

config = '{"Cmd": "date", "Image": "ubuntu"}'
get_response = _request(:post, 'containers/create', {}, config )
ap JSON.parse(get_response)

