# frozen_string_literal: true

module Domains
  module Contacts
    extend Monads::ModulesResponse
    include Repositories

    module_function

    def create_contact(user:, **params)
      contact = Domains::Models::Contact.new(user: user, **params)
      if contact.valid?
        contact = ContactRepo.save!(contact)
        return response(success: true, value: contact)
      end

      response(success: false, value: contact)
    end

    def update_contact(contact_id:, **params)
      contact = ContactRepo.find(contact_id)
      contact.update_attrs(**params.merge(address: { id: contact.address.id, **params[:address] }))
      if contact.valid?
        succeed = ContactRepo.update(contact)
        return response(success: true, value: contact) if succeed
      end

      response(success: false)
    end

    def destroy(contact_id)
      contact = ContactRepo.destroy(contact_id)

      response(success: contact.destroyed?, value: contact)
    end

    def find_all(filters, page)
      ContactRepo.all(filters, page)
    end
  end
end
