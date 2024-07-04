# frozen_string_literal: true

module Domains
  module Models
    class User
      include ActiveModel::Validations

      attr_accessor :name, :email
    end
  end
end
