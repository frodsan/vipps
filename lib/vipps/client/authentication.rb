# frozen_string_literal: true

module Vipps
  class Client
    module Authentication
      def fetch_access_token
        connection.post("/accesstoken/get") do |req|
          req.headers["client_id"] = client_id
          req.headers["client_secret"] = client_secret
          req.headers["Ocp-Apim-Subscription-Key"] = subscription_key
        end
      end
    end
  end
end
