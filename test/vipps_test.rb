require_relative "test_helper"

class VippsTest < Minitest::Test
  def setup
    Vipps.reset_config
  end

  def test_configure
    Vipps.configure do |c|
      c.api_endpoint = "https://apitest.vipps.no"
      c.client_id = "client_id"
      c.client_secret = "client_secret"
      c.subscription_key = "subscription_key"
    end

    assert_equal "https://apitest.vipps.no", Vipps.config.api_endpoint
    assert_equal "client_id", Vipps.config.client_id
    assert_equal "client_secret", Vipps.config.client_secret
    assert_equal "subscription_key", Vipps.config.subscription_key
  end
end
