require_relative "test_helper"

module Vipps
  class ClientTest < Minitest::Test
    attr_reader :client

    setup do
      @options = {
        api_endpoint: Client::API_ENDPOINT_TEST,
        client_id: "client_id",
        client_secret: "client_secret",
        subscription_key: "subscription_key"
      }
      @client = Client.new(**@options)
    end

    test "sets default endpoint" do
      assert_equal "https://api.vipps.no/", Client.new(strict_config: false).api_endpoint
    end

    test "raise error if config is not valid" do
      @options.each_key do |option|
        client = nil

        assert_nothing_raised do
          client = Client.new(**@options)
        end

        assert_raise(ConfigError) do
          client.public_send(:"#{option}=", nil)
          client.validate_config
        end
      end
    end

    test "server can be pinged" do
      assert @client.ping?
    end
  end
end
