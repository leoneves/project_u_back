# frozen_string_literal: true

module Domains
  module Addresses
    extend Monads::ModulesResponse
    include Repositories

    module_function

    def search_addresses(uf, city, street)
      Connectors::ViaCepConnector.new.search_by_address(uf, city, street)
    end

    def search_geographic_coordinates; end
  end
end
