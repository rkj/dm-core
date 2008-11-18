gem 'do_postgis', '>=0.9.7'
require 'do_postgis'
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
      module Migration
        module ClassMethods
          def type_map
            @type_map ||= TypeMap.new(super) do |tm|
              tm.map(DM::Geometry).to('GEOMETRY')
            end
          end
        end # module ClassMethods
      end # module Migration

      include Migration
      extend Migration::ClassMethods
      
    end # class PostgrisAdapter
  end # module Adapters
end # module DataMapper

