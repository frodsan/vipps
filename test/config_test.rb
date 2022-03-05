require_relative "test_helper"

module Vipps
  class ConfigTest < Minitest::Test
    test "sets default endpoint" do
      assert_equal "https://api.vipps.no", Config.new.api_endpoint
    end

    test "raise error if config is not valid" do
      options = {
        api_endpoint: "https://api.vipps.no",
        client_id: "client_id",
        client_secret: "client_secret",
        subscription_key: "subscription_key"
      }

      options.each_key do |option|
        config = Config.new(options)
        assert_nothing_raised do
          config.validate!
        end

        assert_raise(Config::ConfigError) do
          config.public_send(:"#{option}=", "")
          config.validate!
        end
      end
    end
  end
end
