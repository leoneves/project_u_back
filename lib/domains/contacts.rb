# frozen_string_literal: true

module Domains
  module Contacts
    extend Monads::ModulesResponse

    module_function

    def create_contact(user:, **params)
      contact = Domains::Models::Contact.new(user: user, **params)
      if contact.valid?
        contact = Repo.save!(contact)
        return response(success: true, value: contact)
      end

      response(success: false, value: contact)
    end
  end
end
