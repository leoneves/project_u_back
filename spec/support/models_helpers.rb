# frozen_string_literal: true

module ModelsHelpers
  def hash_to_sym(hash_attributes)
    hash = {}
    hash_attributes.each do |k, v|
      next if %i[@validation_context @errors].include?(k)

      hash[k.to_sym] = v
    end
    hash
  end
end
