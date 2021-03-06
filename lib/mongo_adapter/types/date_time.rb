module DataMapper
  module Mongo
    module Types
      class DateTime < DataMapper::Type
        primitive Time

        def self.load(value, property)
          self.typecast(value, property)
        end

        def self.dump(value, property)
          case value
          when Time
            value
          when ::DateTime
            value.utc.to_time
          end
        end

        def self.typecast(value, property)
          case value
          when Time
            value.to_datetime
          when ::DateTime, NilClass, Range
            value
          end
        end
      end
    end # Types
  end # Mongo
end # DataMapper
