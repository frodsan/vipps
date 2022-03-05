module Vipps
  class Config
    class ConfigError < StandardError
    end

    API_ENDPOINT = "https://api.vipps.no".freeze

    DEFAULTS = {
      api_endpoint: API_ENDPOINT
    }.freeze

    attr_accessor :api_endpoint
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :subscription_key

    def initialize(options = {})
      DEFAULTS.merge(options).each do |k, v|
        setter = :"#{k}="
        public_send(setter, v) if respond_to?(setter)
      end
    end

    def validate!
      if api_endpoint.to_s.strip.empty?
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
  end
end
