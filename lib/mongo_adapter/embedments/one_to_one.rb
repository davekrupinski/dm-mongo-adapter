module DataMapper
  module Mongo
    module Embedments
      module OneToOne
        class Relationship < Embedments::Relationship
          # Loads and returns embedment target for given source
          #
          # Returns a new instance of the target model if there isn't one set.
          #
          # @param [DataMapper::Mongo::Resource] source
          #   The resource whose relationship value is to be retrieved.
          #
          # @return [DataMapper::Mongo::Resource]
          #
          # @api semipublic
          def get(source, other_query = nil)
            get!(source)
          end

          # Sets and returns association target for given source
          #
          # @param [DataMapper::Mongo::Resource] source
          #   The resource whose target is to be set.
          # @param [DataMapper::Mongo::EmbeddedResource] target
          #   The value to be set to the target
          # @param [Boolean] loading
          #   Do the attributes have to be loaded before being set? Setting
          #   this to true will typecase the attributes, and set the
          #   original_values on the resource.
          #
          # @api semipublic
          def set(source, target, loading=false)
            assert_kind_of 'source', source, source_model
            assert_kind_of 'target', target, target_model, Hash, NilClass

            unless target.nil?
              if target.kind_of?(Hash)
                target = load_target(source, target, loading)
              else
                target.parent = source
              end

              set_original_attributes(source, target) unless loading
            end

            set!(source, target)
          end

          # @api public
          def storage_name
            @storage_name ||= target_model.storage_name.singularize
          end
        end # Relationship
      end # OneToOne
    end # Embedments
  end # Mongo
end # DataMapper
