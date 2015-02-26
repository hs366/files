#!/usr/bin/ruby
require 'json'
require 'socket'
require 'excon'
require 'awesome_print'
require 'logger'

$logger = Logger.new($stdout)
$logger.level = Logger::DEBUG 

class Request
  def initialize(htmethod, endpoint, options = {}, body = "")
    @htmethod = htmethod
    @endpoint = endpoint
    @options = options
    @body = body
  end

  def _request
    rs = @endpoint
    unless @options == {}
      @options.each {|r| rs += "&" + 
        URI.escape(r[0].to_s) + "=" + 
        URI.escape(r[1].to_s) }
    end
   # $logger.debug("docker/_request htmethod=#{htmethod} endpint=#{endpoint}, request=unix:///#{rs}, body=#{body}")
    case @htmethod
    when :get
      response = Excon.get("unix:///#{rs}", :socket => '/var/run/docker.sock')
    when :post
      response = Excon.post("unix:///#{rs}", 
                            :socket => '/var/run/docker.sock', 
                            :body => @body, 
                            :headers => {"Content-Type" => "application/json"})
    when :delete
      response = Excon.delete("unix:///#{rs}", 
                              :socket => '/var/run/docker.sock', 
                              :body => @body, 
                              :headers => {"Content-Type" => "application/json"})
    else
      raise "Internal error"
    end
     $logger.debug "this is response body#{response.status}"
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
end

# TODO: the out put should be appropriate with docker API (expected to have; status code or body or ...) 
#
#get_response1 = Request.new(:get, 'version')._request
#ap puts(get_response1)
#puts get_response1.body 

#config = '{"Cmd": "date", "Image": "ubuntu"}'
#get_response = Request.new(:post,'containers/create', {}, config)._request
#ap puts(get_response)

#id = "3ce39d37ab2d" 
#get_response2 = Request.new(:delete,"containers/#{id}", {}, "")._request
#ap puts get_response2
