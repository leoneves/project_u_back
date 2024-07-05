# frozen_string_literal: true

module Api
  module V1
    class AddressesController < ApplicationController
      include Domains

      before_action :check_user_authentication

      def search_addresses
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
