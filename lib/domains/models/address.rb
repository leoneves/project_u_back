# frozen_string_literal: true

module Domains
  module Models
    class Address
      include ActiveModel::Serialization
      include ActiveModel::Validations
      include Utils::AttributesUtils

      attr_accessor :id, :cep, :latitude, :longitude, :address, :address_complement, :uf, :contact_id, :contact

      validates :cep, presence: true
      validates :latitude, presence: true
      validates :longitude, presence: true
      validates :address, presence: true
      validates :uf, presence: true
      validates :contact_id, presence: true

      def initialize(contact: nil, **params)
        assign_attributes(contact: contact, **params)
      end

      private

      def assign_attributes(contact: nil, **params)
        @id ||= params[:id]
        @contact_id ||= params[:contact_id]
        @cep = params[:cep]
        @latitude = params[:latitude]
        @longitude = params[:longitude]
        @address = params[:address]
        @uf = params[:uf]
        @address_complement = params[:address_complement]
        @contact = contact if contact.present?
      end
    end
  end
end
