# frozen_string_literal: true

module Utils
  module AttributesUtils
    HELPER_ATTRIBUTES = %i[@validation_context @errors @action @ignore_validations_for].freeze

    def attributes
      hash = {}
      instance_variables.each do |v|
        next if HELPER_ATTRIBUTES.include?(v)

        hash[v.to_s.delete('@').to_sym] = instance_variable_get(v)
      end
      hash.compact
    end

    def attributes_without_assoc
      hash = {}
      instance_variables.each do |v|
        next if HELPER_ATTRIBUTES.include?(v) || instance_variable_get(v).respond_to?(:attributes)

        hash[v.to_s.delete('@').to_sym] = instance_variable_get(v)
      end
      hash.compact
    end

    def attributes_not_included_in(params)
      instance_variables.map do |v|
        v.to_s.delete('@').to_sym unless params.keys.include?(v.to_s.delete('@').to_sym)
      end.compact
    end
  end
end
