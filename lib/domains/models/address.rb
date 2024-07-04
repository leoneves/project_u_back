# frozen_string_literal: true

module Domains
  module Models
    class Address
      include ActiveModel::Serialization
      include ActiveModel::Validations
      include Utils::AttributesUtils

      attr_accessor :id, :cep, :latitude, :longitude, :address, :address_complement, :contact_id, :contact

      validates :cep, presence: true
      validates :latitude, presence: true
      validates :longitude, presence: true
      validates :address, presence: true
      validates :contact_id, presence: true

      def initialize(contact: nil, **params)
        @id = params[:id]
        @contact_id = params[:contact_id]
        @cep = params[:cep]
        @latitude = params[:latitude]
        @longitude = params[:longitude]
        @address = params[:address]
        @address_complement = params[:address_complement]
        @contact = contact
      end
    end
  end
end
