require "faraday"
require_relative "vipps/version"
require_relative "vipps/client"

module Vipps
  class << self
    def client
      @client ||= Vipps::Client.new
    end

    def configure
      yield client
    end

    def reset! # :nodoc:
      @client = nil
    end

    private

    def method_missing(method, *args, &block)
      if client.respond_to?(method)
        client.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, *_, &_)
      client.respond_to?(method)
    end
  end
end
