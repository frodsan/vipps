module Vipps
  class Client
    API_ENDPOINT = "https://api.vipps.no/".freeze
    USER_AGENT = "Vipps Ruby Gem #{Vipps::VERSION}".freeze

    attr_reader :api_endpoint
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :subscription_key
    attr_accessor :user_agent

    def initialize(
      api_endpoint: API_ENDPOINT,
      client_id: nil,
      client_secret: nil,
      subscription_key: nil,
      user_agent: USER_AGENT
    )
      self.api_endpoint = api_endpoint
      self.client_id = client_id
      self.client_secret = client_secret
      self.subscription_key = subscription_key
      self.user_agent = user_agent
    end

    def api_endpoint=(url)
      @api_endpoint = url && File.join(url, "")
    end

    class ConfigError < StandardError
    end

    def validate_options!
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

    def ping
      connection.get("/mobileintercept/")
    end
  end
end
