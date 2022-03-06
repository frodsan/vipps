# frozen_string_literal: true

require_relative "client/resource"
require_relative "client/authentication"

module Vipps
  class Client
    include Authentication

    # Default API endpoint
    API_ENDPOINT = "https://api.vipps.no/"

    # Default User-Agent header string
    USER_AGENT = "Vipps Ruby Gem #{Vipps::VERSION}"

    attr_accessor :api_endpoint
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :subscription_key
    attr_accessor :user_agent

    def initialize(
      api_endpoint: nil,
      client_id: nil,
      client_secret: nil,
      subscription_key: nil,
      user_agent: nil
    )
      self.api_endpoint = api_endpoint || API_ENDPOINT
      self.client_id = client_id
      self.client_secret = client_secret
      self.subscription_key = subscription_key
      self.user_agent = user_agent || USER_AGENT
    end

    def ping?
      ping&.success?
    end

    def ping # :nodoc:
      connection.get("/mobileintercept/")
    end

    private

    def connection
      @connection ||= Faraday.new(connection_options) do |f|
        f.request :json
        f.response :json
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
