module Npush
  require 'net/http'
  require 'uri'
  
  class Engine < ::Rails::Engine
    #adds socket.io.min.js from /vendor to asset pipeline
  end

  class << self
    def push(user, event, obj)
      uri = URI.parse(ENV['npush_server'])
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.content_type = 'application/json'
      @body = {}
      @body["secret"] = ENV['npush_secret']
      @body["user"] = user
      @body["event"] = event
      @body["obj"] = obj
      request.body = @body.to_json
      response = http.request(request)
    end
    
    def broadcast(channel, event, obj)
      uri = URI.parse(ENV['npush_server'])
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.content_type = 'application/json'
      @body = {}
      @body["secret"] = ENV['npush_secret']
      @body["channel"] = channel
      @body["event"] = event
      @body["obj"] = obj
      request.body = @body.to_json
      response = http.request(request)
    end
  end
end
