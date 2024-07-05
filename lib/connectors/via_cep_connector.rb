# frozen_string_literal: true

module Connectors
  class ViaCepConnector
    def initialize
      @conn = Faraday.new(
        url: 'https://viacep.com.br',
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def search_by_address(uf, city, street)
      uri = URI::Parser.new.escape("ws/#{uf}/#{city}/#{street}/json")
      response = @conn.get(uri)
      JSON.parse(response.body, symbolize_names: true)
    end

    def search_by_cep(cep)
      uri = URI::Parser.new.escape("ws/#{cep}/json")
      response = @conn.get(uri)
      JSON.parse(response.body, symbolize_names: true) if response.status == 200
    end
  end
end
