# frozen_string_literal: true

module Api
  module V1
    class AddressesController < ApplicationController
      include Domains

      before_action :check_user_authentication

      def search_addresses
        return find_by_cep(params) if params[:cep].present?

        find_by_address(params)
      end

      def find_location_on_map
        address = params.require(:address)
        locations = Addresses.search_geographic_coordinates(address)

        response = locations.map do |location|
          {
            complete_address: location[:formatted_address],
            latitude: location.dig(:geometry, :location, :lat),
            longitude: location.dig(:geometry, :location, :lng)
          }
        end
        return render json: response, status: :ok unless locations.empty?

        head :not_found
      rescue ActionController::ParameterMissing => e
        render json: { message: e.message }, status: :bad_request
      end

      private

      def find_by_cep(params)
        addresses = Addresses.search_by_cep(params[:cep])
        return render json: addresses, status: :ok unless addresses.nil?

        head :not_found
      end

      def find_by_address(params)
        require_params = params.require(%i[uf city street])
        addresses = Addresses.search_addresses(*require_params)
        return render json: addresses, status: :ok unless addresses.empty?

        head :not_found
      rescue ActionController::ParameterMissing => e
        render json: { message: e.message }, status: :bad_request
      end
    end
  end
end
