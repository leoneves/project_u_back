# frozen_string_literal: true

module Repositories
  module ContactRepo
    module_function

    def find(id)
      as_domain(Contact.eager_load(:user).where(id: id).first)
    end

    def save!(contact)
      contact.address = Address.new(contact.address.attributes)
      model_contact = Contact.create!(contact.attributes)
      as_domain(model_contact)
    end

    def as_domain(record)
      address = Domains::Models::Address.new(**record.address.attributes.symbolize_keys)
      Domains::Models::Contact.new(
        user: record.user, address: address, **record.attributes.symbolize_keys
      )
    end

    private_methods %i[as_domain]
  end
end
