# frozen_string_literal: true

module Utils
  module AttributesUtils
    def attributes
      hash = {}
      instance_variables.each do |v|
        next if %i[@validation_context @errors @action].include?(v)

        hash[v.to_s.delete('@').to_sym] = instance_variable_get(v)
      end
      hash.compact
    end

    def attributes_without_assoc
      hash = {}
      instance_variables.each do |v|
        next if %i[@validation_context @errors @action].include?(v) || instance_variable_get(v).respond_to?(:attributes)

        hash[v.to_s.delete('@').to_sym] = instance_variable_get(v)
      end
      hash.compact
    end
  end
end
