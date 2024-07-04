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

    def find_all(filters, page)
      ContactRepo.all(filters, page)
    end
  end
end
