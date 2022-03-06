# frozen_string_literal: true

require_relative "test_helper"


class ClientTest < Minitest::Test
  test "sets defaults" do
    client = Vipps::Client.new

    assert_equal Vipps::Client::API_ENDPOINT, client.api_endpoint
    assert_equal Vipps::Client::USER_AGENT, client.user_agent
  end
end
