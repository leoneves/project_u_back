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
    end
  end
end
