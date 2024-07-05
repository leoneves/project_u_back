# frozen_string_literal: true

module Domains
  module Models
    class Contact
      include ActiveModel::Serialization
      include ActiveModel::Validations
      include Utils::AttributesUtils

      attr_accessor :id, :name, :cpf, :phone, :user_id, :user
      attr_reader :address

      validates :name, presence: true
      validates :cpf, presence: true
      validates :phone, presence: true
      validates :user_id, presence: true
      validates :user, presence: true
      validates :address, presence: true
      validate :cpf_already_exist
      validates_cpf_format_of :cpf

      def initialize(user:, **params)
        @action = :create
        assign_attributes(user: user, **params)
      end

      def update_attrs(**params)
        @action = :update_attrs
        assign_attributes(user: nil, **params)
      end

      def address=(address)
        return if address.nil?

        @address = address.instance_of?(Hash) ? Address.new(**address.symbolize_keys!) : address
      end

      def cpf_already_exist
        return false if @action == :update_attrs
        return unless Repositories::ContactRepo.cpf_already_exist?(@cpf)

        errors.add(:cpf, 'This cpf is already in use in our base')
      end

      private

      def assign_attributes(user:, **params)
        @id ||= params[:id]
        @name = params[:name]
        @cpf = params[:cpf]
        @phone = params[:phone]
        @user_id ||= params[:user_id]
        @user ||= user
        self.address = params[:address]
      end
    end
  end
end
