# frozen_string_literal: true

module Vipps
  class Client
    module Authentication
      def access_token
        res = fetch_access_token
        AccessToken.new(res.body)
      end

      private def fetch_access_token
        connection.post("/accesstoken/get") do |req|
          req.headers["client_id"] = client_id
          req.headers["client_secret"] = client_secret
          req.headers["Ocp-Apim-Subscription-Key"] = subscription_key
        end
      end

      class AccessToken < Resource
        attribute :token_type
        attribute :access_token
        attribute :expires_in, cast: :int
        attribute :extended_expires_in, cast: :int
        attribute :expires_on, cast: :unix_time
        attribute :not_before, cast: :unix_time
        attribute :resource

        # Expire token 5 seconds before it's actual expiration date,
        # so the client never sends an expired token to Vipps servers.
        def expired?
          (expires_on - 5) < Time.now.utc
        end

        def active?
          !expired?
        end
      end
    end
  end
end
