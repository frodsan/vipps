# frozen_string_literal: true

module Vipps
  module Default
    # Default API endpoint
    API_ENDPOINT = "https://api.vipps.no/"

    # Default User-Agent header string
    USER_AGENT = "Vipps Ruby Gem #{Vipps::VERSION}"

    class << self
      def api_endpoint
        ENV["VIPPS_API_ENDPOINT"] || API_ENDPOINT
      end

      def client_id
        ENV["VIPPS_CLIENT_ID"]
      end

      def client_secret
        ENV["VIPPS_CLIENT_SECRET"]
      end

      def subscription_key
        ENV["VIPPS_SUBSCRIPTION_KEY"]
      end

      def user_agent
        ENV["VIPPS_USER_AGENT"] || USER_AGENT
      end
    end
  end
end
