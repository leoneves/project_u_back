# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      include RackSessionFixController

      respond_to :json

      def auth_options
        super.merge({ store: false })
      end

      private

      def respond_with(resource, _opts = {})
        render json: resource
      end

      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
