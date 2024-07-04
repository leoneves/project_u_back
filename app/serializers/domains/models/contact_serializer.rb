# frozen_string_literal: true

module Domains
  module Models
    class ContactSerializer < ActiveModel::Serializer
      attributes :id, :name, :cpf, :phone, :user_id, :address

      def address
        Domains::Models::AddressSerializer.new(object.address)
      end
    end
  end
end
