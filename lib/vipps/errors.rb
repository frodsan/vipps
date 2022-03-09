# frozen_string_literal: true

module Vipps
  # Custom error class for rescuing from all Vipps errors.
  class Error < StandardError
    class << self
      # Returns the appropriate Vipps::Error subclass based on the response status.
      #
      # @param [Faraday::Env] env HTTP request environment
      # @return [Vipps::Error]
      def from_response(env)
        case env.status
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
        end&.new(env)
      end
    end

    protected def initialize(env)
      @env = env
      super(build_error_message)
    end

    private def build_error_message
      # GET https://api.vipps.no/: 401
      format(
        "%<method>s %<url>s: %<status>d",
        method: request_method.upcase,
        url: request_url,
        status: response_status
      )
    end

    # HTTP method of the request sent.
    #
    # @return [Symbol]
    def request_method
      @env.method
    end

    # URL of the request sent.
    #
    # @return [URI::HTTPS]
    def request_url
      @env.url
    end

    # Included HTTP headers in the request sent.
    #
    # @return [Hash]
    def request_headers
      @env.request_headers
    end

    # Body of the request sent.
    #
    # @return [String]
    def request_body
      @env.request_body
    end

    # Status code returned by the Vipps server.
    #
    # @return [Integer]
    def response_status
      @env.status
    end

    # Headers returned by the Vipps server.
    #
    # @return [Hash]
    def response_headers
      @env.response_headers
    end

    # Body returned by the Vipps server.
    #
    # @return [String]
    def response_body
      @env.response_body
    end

    # Decoded version of response body. If response content type is JSON,
    # it returns a Hash. Otherwise, returns #response_body.
    #
    # @return [Hash, String]
    def response_data
      @data ||= decode_response_data
    end

    private

    def decode_response_data
      body = response_body
      return nil unless body && !body.empty?
      return body unless body.is_a?(String) && response_is_json?
      JSON.parse(body)
    end

    def response_is_json?
      /json/ === response_headers&.[](:content_type)
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
