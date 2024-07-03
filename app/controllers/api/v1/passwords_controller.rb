# frozen_string_literal: true

module Api
  module V1
    class PasswordsController < Devise::PasswordsController
      respond_to :json

      # POST /password
      def create
        self.resource = resource_class.send_reset_password_instructions(resource_params)
        yield resource if block_given?

        if successfully_sent?(resource)
          respond_with({ message: 'Request successful' })
        else
          respond_with(resource, :not_found)
        end
      end

      # PUT /password
      def update
        self.resource = resource_class.reset_password_by_token(resource_params)
        yield resource if block_given?

        if resource.errors.empty?
          resource.unlock_access! if unlockable?(resource)
          if Devise.sign_in_after_reset_password
            flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
            set_flash_message!(:notice, flash_message)
            resource.after_database_authentication
            sign_in(resource_name, resource)
          else
            set_flash_message!(:notice, :updated_not_active)
          end
          respond_with(resource)
        else
          set_minimum_password_length
          respond_with(resource, :not_found)
        end
      end

      private

      def respond_with(resource = {}, status = :ok, _opts = {})
        render json: resource, status: status
      end
    end
  end
end
