# frozen_string_literal: true

require "faraday"
require "vipps/version"
require "vipps/default"
require "vipps/errors"
require "vipps/client"

module Vipps
  class << self
    def client
      @client ||= Vipps::Client.new
    end

    def configure
      yield client
    end

    # @api private
    def reset!
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

    def respond_to_missing?(method, *)
      client.respond_to?(method) || super
    end
  end
end
