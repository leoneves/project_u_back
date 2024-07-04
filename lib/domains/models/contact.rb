# frozen_string_literal: true

module Domains
  module Models
    class Contact
      include ActiveModel::Serialization
      include ActiveModel::Validations
      include Utils::AttributesUtils

      attr_accessor :id, :name, :cpf, :phone, :user_id, :user, :address

      validates :name, presence: true
      validates :cpf, presence: true
      validates :phone, presence: true
      validates :user_id, presence: true
      validates :user, presence: true

      def initialize(user:, **params)
        @id = params[:id]
        @name = params[:name]
        @cpf = params[:cpf]
        @phone = params[:phone]
        @user_id = params[:user_id]
        @user = user
        @address = params[:address]
      end
    end
  end
end
