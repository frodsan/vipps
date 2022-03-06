require_relative "test_helper"

class VippsTest < Minitest::Test
  setup do
    Vipps.reset!
    Vipps.configure do |c|
      c.api_endpoint = "https://apitest.vipps.no"
    end
  end

  test "can be configured" do
    assert_equal "https://apitest.vipps.no/", Vipps.api_endpoint
  end

  test "forward methods to default client" do
    assert Vipps.ping?
  end
end
