require 'dm-core/adapters/postgres_adapter'
begin
  require 'geo_ruby'
rescue LoadError
  STDERR.puts <<-EOS
You must install the GeoRuby gem.
  gem install GeoRuby
EOS
  exit
end

module DataMapper
  module Adapters
    class PostgisAdapter < PostgresAdapter
			def type_cast_geometry(raw_value)
				return nil if raw_value.nil? || raw_value.empty?
				return GeoRuby::SimpleFeatures::Geometry.from_hex_ewkb(raw_value)
			end

      module Migration
        module ClassMethods
          def type_map
            @type_map ||= TypeMap.new(super) do |tm|
              tm.map(geometry).to('GEOMETRY')
            end
          end
        end # module ClassMethods
      end # module Migration

      include Migration
      extend Migration::ClassMethods
      
    end # class PostgrisAdapter
  end # module Adapters
end # module DataMapper

