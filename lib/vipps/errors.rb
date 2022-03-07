# frozen_string_literal: true

module Vipps
  # Custom error class for rescuing from all Vipps errors.
  class Error < StandardError
    class << self
      # Returns the appropriate Vipps::Error subclass based on the response status.
      #
      # @param [Hash] response HTTP response
      # @return [Vipps::Error]
      def from_response(response)
        klass = case response[:status].to_i
          when 400 then BadRequest
          when 401 then Unauthorized
          when 403 then Forbidden
          when 404 then NotFound
          when 405 then MethodNotAllowed
          when 406 then NotAcceptable
          when 409 then Conflict
          when 415 then UnsupportedMediaType
          when 422 then UnprocessableEntity
          when 451 then UnavailableForLegalReasons
          when 400..499 then ClientError
          when 500 then InternalServerError
          when 501 then NotImplemented
          when 502 then BadGateway
          when 503 then ServiceUnavailable
          when 500..599 then ServerError
        end

        klass&.new(response)
      end
    end

    def initialize(response) # :nodoc:
      @response = response
    end

    # Status code returned by the Vipps server.
    #
    # @return [Integer]
    def response_status
      @response[:status]
    end

    # Headers returned by the Vipps server.
    #
    # @return [Hash]
    def response_headers
      @response[:response_headers]
    end

    # Body returned by the Vipps server.
    #
    # @return [String]
    def response_body
      @response[:body]
    end
  end

  # Raised on errors in the 400-499 range.
  class ClientError < Error; end

  # Raised when Vipps returns a 400 HTTP status code.
  class BadRequest < ClientError; end

  # Raised when Vipps returns a 401 HTTP status code.
  class Unauthorized < ClientError; end

  # Raised when Vipps returns a 403 HTTP status code.
  class Forbidden < ClientError; end

  # Raised when Vipps returns a 404 HTTP status code.
  class NotFound < ClientError; end

  # Raised when Vipps returns a 405 HTTP status code.
  class MethodNotAllowed < ClientError; end

  # Raised when Vipps returns a 406 HTTP status code.
  class NotAcceptable < ClientError; end

  # Raised when Vipps returns a 409 HTTP status code.
  class Conflict < ClientError; end

  # Raised when Vipps returns a 414 HTTP status code.
  class UnsupportedMediaType < ClientError; end

  # Raised when Vipps returns a 422 HTTP status code.
  class UnprocessableEntity < ClientError; end

  # Raised when Vipps returns a 451 HTTP status code.
  class UnavailableForLegalReasons < ClientError; end

  # Raised on errors in the 500-599 range.
  class ServerError < Error; end

  # Raised when Vipps returns a 500 HTTP status code.
  class InternalServerError < ServerError; end

  # Raised when Vipps returns a 501 HTTP status code.
  class NotImplemented < ServerError; end

  # Raised when Vipps returns a 502 HTTP status code.
  class BadGateway < ServerError; end

  # Raised when Vipps returns a 503 HTTP status code.
  class ServiceUnavailable < ServerError; end
end
