require_relative "test_helper"

module Vipps
  class ClientTest < Minitest::Test
    test "sets default endpoint" do
      assert_equal "https://api.vipps.no/", Client.new.api_endpoint
    end

    test "raise error if config is not valid" do
      options = {
        api_endpoint: "https://api.vipps.no",
        client_id: "client_id",
        client_secret: "client_secret",
        subscription_key: "subscription_key"
      }

      options.each_key do |option|
        config = Client.new(**options)
        assert_nothing_raised do
          config.validate_options!
        end

        assert_raise(Client::ConfigError) do
          config.public_send(:"#{option}=", nil)
          config.validate_options!
        end
      end
    end
  end
end
