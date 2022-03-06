# frozen_string_literal: true

require_relative "test_helper"

class ClientTest < Minitest::Test
  test "use default api endpoint" do
    assert_equal Vipps::Default.api_endpoint, Vipps::Client.new.api_endpoint
  end
end
