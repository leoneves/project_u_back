# frozen_string_literal: true

module Domains
  module Models
    class AddressSerializer < ActiveModel::Serializer
      attributes :id, :cep, :latitude, :longitude, :address, :address_complement, :contact_id

      def latitude
        object.latitude.to_f
      end

      def longitude
        object.longitude.to_f
      end
    end
  end
end
