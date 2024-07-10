# frozen_string_literal: true

module Domains
  module Models
    class Contact
      include ActiveModel::Serialization
      include ActiveModel::Validations
      include Utils::AttributesUtils

      attr_accessor :id, :name, :cpf, :phone, :user_id, :user
      attr_reader :address, :action
      attr_writer :ignore_validations_for

      validates :name, presence: true, unless: proc { @ignore_validations_for.include?(:name) }
      validates :cpf, presence: true, unless: proc { @ignore_validations_for.include?(:cpf) }
      validates :phone, presence: true, unless: proc { @ignore_validations_for.include?(:phone) }
      validates :user_id, presence: true, unless: proc { @ignore_validations_for.include?(:user_id) }
      validates :user, presence: true, unless: proc { @ignore_validations_for.include?(:user) }
      validates :address, presence: true, unless: proc { @ignore_validations_for.include?(:address) }
      validate :cpf_already_exist, unless: proc { @ignore_validations_for.include?(:cpf) }
      validates_cpf_format_of :cpf, unless: proc { @ignore_validations_for.include?(:cpf) }

      def initialize(user:, **params)
        @action = :create
        assign_attributes(user: user, **params)
      end

      def update_attrs(**params)
        @action = :update_attrs
        assign_attributes(user: nil, **params)
        @address = nil if @address.attributes.empty?
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

      def can_not_found_error
        errors.add(:id, 'Can not found a contact with this id')
        self
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
        @ignore_validations_for = []
      end
    end
  end
end
