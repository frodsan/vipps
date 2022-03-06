require_relative "test_helper"

class VippsTest < Minitest::Test
  setup do
    Vipps.configure do |c|
      c.api_endpoint = "https://apitest.vipps.no"
      c.client_id = "client_id"
      c.client_secret = "client_secret"
      c.subscription_key = "subscription_key"
    end
  end

  test "can be configured" do
    assert_equal "https://apitest.vipps.no/", Vipps.api_endpoint
  end

  test "configure raises error if config is missing" do
    assert_raise(Vipps::ConfigError) do
      Vipps.configure { }
    end
  end

  test "forward methods to default client" do
    assert Vipps.ping?
  end
end
