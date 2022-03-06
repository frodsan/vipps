# frozen_string_literal: true

require "minitest/autorun"
require "minitest/candy"
require "minitest/pride"
require "vipps"

class MiniTest::Test
  setup do
    Vipps.configure do |c|
      c.api_endpoint = "https://apitest.vipps.no"
      c.client_id = "client_id"
      c.client_secret = "client_secret"
      c.subscription_key = "subscription_key"
    end
  end
end
