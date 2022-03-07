# frozen_string_literal: true

require "vipps/response/raise_error"
require "vipps/client/resource"
require "vipps/client/authentication"

module Vipps
  class Client
    include Authentication

    attr_accessor :api_endpoint
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :subscription_key
    attr_accessor :user_agent

    def initialize(
      api_endpoint: Default.api_endpoint,
      client_id: Default.client_id,
      client_secret: Default.client_secret,
      subscription_key: Default.subscription_key,
      user_agent: Default.user_agent
    )
      self.api_endpoint = api_endpoint
      self.client_id = client_id
      self.client_secret = client_secret
      self.subscription_key = subscription_key
      self.user_agent = user_agent
    end

    def ping?
      ping&.success?
    end

    def ping
      connection.get("/mobileintercept/")
    end

    private

    def connection
      @connection ||= Faraday.new(connection_options) do |f|
        f.request :json
        f.response :json
        f.use Response::RaiseError
      end
    end

    def connection_options
      {
        url: api_endpoint,
        headers: {
          user_agent: user_agent
        }
      }
    end
  end
end
