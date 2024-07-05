# frozen_string_literal: true

module Connectors
  class GoogleMapsConnector
    def initialize
      @conn = Faraday.new(
        url: 'https://maps.googleapis.com',
        headers: { 'Content-Type' => 'application/json' }
      )
      @google_api_key = ENV.fetch('GOOGLE_API_KEY')
    end

    def search_geo_location(address)
      uri = URI::Parser.new.escape("maps/api/geocode/json?address=#{address}&language=pt-BR&key=#{@google_api_key}")
      response = @conn.get(uri)
      JSON.parse(response.body, symbolize_names: true)[:results] if response.status == 200
    end
  end
end
