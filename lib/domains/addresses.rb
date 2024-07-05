# frozen_string_literal: true

module Domains
  module Addresses
    extend Monads::ModulesResponse
    include Repositories

    module_function

    def search_addresses(uf, city, street)
      Connectors::ViaCepConnector.new.search_by_address(uf, city, street)
    end

    def search_by_cep(cep)
      Connectors::ViaCepConnector.new.search_by_cep(cep)
    end

    def search_geographic_coordinates(address)
      Connectors::GoogleMapsConnector.new.search_geo_location(address)
    end
  end
end
