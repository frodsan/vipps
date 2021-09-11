require_relative "vipps/version"
require_relative "vipps/config"

module Vipps
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end

    def reset_config # :nodoc:
      @config = nil
    end
  end
end
