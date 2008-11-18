require 'geo_ruby'
require 'pp'
module DataMapper
  module Types
    class Geometry < DataMapper::Type
      primitive GeoRuby::SimpleFeatures::Geometry
      default nil

      def self.dump(value, property)
        value.nil? ? nil : value.as_hex_ewkb
      end

      def self.load(value, property)
        value.nil? ? nil : GeoRuby::SimpleFeatures::Geometry.from_hex_ewkb(value)
      end
    end # class Text
  end # module Types
end # module DataMapper
