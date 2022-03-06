# frozen_string_literal: true

module Vipps
  class Client
    class Resource
      module TypeCasting
        Integer = ->(x) { x&.to_i }
        UnixTime = ->(x) { x && Time.at(x.to_i) }

        def self.from(type)
          case type
          when :int then Integer
          when :unix_time then UnixTime
          end
        end
      end

      def self.attribute(name, cast: nil)
        name = name.to_s

        if cast
          cast = TypeCasting.from(cast) || cast

          define_method(name) do
            cast[@attributes[name]]
          end
        else
          define_method(name) do
            @attributes[name]
          end
        end
      end

      attr_reader :attributes

      def initialize(new_attributes)
        @attributes = new_attributes
      end

      def inspect
        @attributes
      end
    end
  end
end
