# frozen_string_literal: true

require_relative "test_helper"

class VippsTest < Minitest::Test
  test "can be configured" do
    assert_equal "https://apitest.vipps.no/", Vipps.api_endpoint
  end

  test "configure raises error if config is missing" do
    assert_raise(Vipps::ConfigError) do
      Vipps.configure {}
    end
  end

  test "forward methods to default client" do
    assert Vipps.ping?
  end
end
