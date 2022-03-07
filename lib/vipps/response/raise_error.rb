# frozen_string_literal: true

module Vipps
  module Response # @private
    class RaiseError < Faraday::Middleware
      def on_complete(response)
        if (error = Vipps::Error.from_response(response))
          raise error
        end
      end
    end
  end
end
