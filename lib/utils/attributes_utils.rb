# frozen_string_literal: true

module Utils
  module AttributesUtils
    def attributes
      hash = {}
      instance_variables.each do |v|
        next if %i[@validation_context @errors].include?(v)

        hash[v.to_s.delete('@').to_sym] = instance_variable_get(v)
      end
      hash
    end
  end
end
