# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      include RackSessionFixController
      respond_to :json

      def create
        build_resource(permitted_params)

        resource.save
        render json: resource
      end

      def build_resource(hash = {})
        self.resource = resource_class.new(hash)
      end

      def permitted_params
        params.permit(%i[name email password password_confirmation])
      end
    end
  end
end
