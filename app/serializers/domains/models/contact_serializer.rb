# frozen_string_literal: true

module Domains
  module Models
    class ContactSerializer < ActiveModel::Serializer
      attributes :id, :name, :cpf, :phone, :user_id, :address

      def address
        Domains::Models::AddressSerializer.new(@object.address) unless @object.address.nil?
      end

      def user_id
        @object.user_id unless @object.action == :update_attrs
      end

      def id
        @object.id unless @object.action == :update_attrs
      end

      def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
        hash = super
        hash.each { |key, value| hash.delete(key) if value.nil? }
        hash
      end
    end
  end
end
