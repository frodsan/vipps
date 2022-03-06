# frozen_string_literal: true

require_relative "test_helper"


class ClientTest < Minitest::Test
  test "sets defaults" do
    client = Vipps::Client.new(strict_config: false)

    assert_equal Vipps::Client::API_ENDPOINT, client.api_endpoint
    assert_equal Vipps::Client::USER_AGENT, client.user_agent
  end

  test "raise error if config is not valid" do
    options = {
      api_endpoint: "https://api.vipps.no",
      client_id: "client_id",
      client_secret: "client_secret",
      subscription_key: "subscription_key"
    }

    options.each_key do |option|
      client = nil

      assert_nothing_raised do
        client = Vipps::Client.new(**options)
      end

      assert_raise(Vipps::ConfigError) do
        client.public_send(:"#{option}=", nil)
        client.validate_config
      end
    end
  end
end
