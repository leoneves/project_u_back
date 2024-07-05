# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApplicationController
      include Domains

      before_action :check_user_authentication

      def index
        page = (params[:page] || 1).to_i
        filters = params.slice(:user_id, :name, :cpf)

        contacts = Contacts.find_all(filters, page)
        render json: contacts, status: :ok if contacts.any?
      end

      def create
        response = Domains::Contacts.create_contact(user: current_user, **permitted_params(params).merge(user_id: current_user.id))
        return render json: response.value, status: :created if response.success?

        return render json: response.value.errors, status: :unprocessable_content unless response.value.errors.empty?

        render json: response.value.address.errors, status: :unprocessable_content
      end

      def update
        response = Contacts.update_contact(contact_id: params[:id], **permitted_params(params))
        return render json: response.value, status: :ok if response.success?

        return render json: response.value.errors, status: :unprocessable_content unless response.value.errors.empty?

        render json: response.value.address.errors, status: :unprocessable_content
      end

      def destroy
        response = Contacts.destroy(params[:id])
        return head :ok if response.success?

        head :server_error
      end

      private

      def permitted_params(params)
        params.permit(
          :id, :name, :cpf, :phone, :user_id, :user,
          { address: %i[id cep latitude longitude address uf address_complement contact_id contact] }
        ).to_h.symbolize_keys
      end
    end
  end
end
