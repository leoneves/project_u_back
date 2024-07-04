# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        key = "#{key}_scope" if %w[name].include?(key)
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
