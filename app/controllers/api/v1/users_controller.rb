# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Domains

      before_action :check_user_authentication

      def destroy
        params.require(%i[id password])
        return head :unauthorized unless current_user.valid_password?(params[:password])

        Users.delete_user(params[:id])
      end
    end
  end
end
