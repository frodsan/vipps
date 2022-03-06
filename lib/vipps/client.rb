# frozen_string_literal: true

require_relative "client/resource"
require_relative "client/authentication"

module Vipps
  class Client
    include Authentication

    # Default API endpoint
    API_ENDPOINT = "https://api.vipps.no/"

    # Default API endpoint for test environment
    API_ENDPOINT_TEST = "https://apitest.vipps.no/"

    # Default User-Agent header string
    USER_AGENT = "Vipps Ruby Gem #{Vipps::VERSION}"

    attr_reader :api_endpoint
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :subscription_key
    attr_accessor :user_agent

    def initialize(
      api_endpoint: nil,
      client_id: nil,
      client_secret: nil,
      subscription_key: nil,
      user_agent: nil,
      strict_config: true
    )
      self.api_endpoint = api_endpoint || API_ENDPOINT
      self.client_id = client_id
      self.client_secret = client_secret
      self.subscription_key = subscription_key
      self.user_agent = user_agent || USER_AGENT
      validate_config if strict_config
    end

    def api_endpoint=(url)
      @api_endpoint = url && File.join(url, "")
    end

    def validate_config
      if api_endpoint.nil? || api_endpoint.empty?
        raise ConfigError.new("api_endpoint config is missing")
      end

      if client_id.nil? || client_id.empty?
        raise ConfigError.new("client_id config is missing")
      end

      if client_secret.nil? || client_secret.empty?
        raise ConfigError.new("client_secret config is missing")
      end

      if subscription_key.nil? || subscription_key.empty?
        raise ConfigError.new("subscription_key config is missing")
      end
    end

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

    def ping?
      ping&.success?
    end

    def ping # :nodoc:
      connection.get("/mobileintercept/")
    end
  end
end
