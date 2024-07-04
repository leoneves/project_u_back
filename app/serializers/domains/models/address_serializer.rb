# frozen_string_literal: true

module Domains
  module Models
    class AddressSerializer < ActiveModel::Serializer
      attributes :id, :cep, :latitude, :longitude, :address, :address_complement, :contact_id
    end
  end
end
