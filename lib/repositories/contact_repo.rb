# frozen_string_literal: true

module Repositories
  module ContactRepo
    module_function

    def find(id)
      as_domain(Contact.eager_load(:user).where(id: id).first)
    end

    def all(filters, page)
      as_domains(Contact.filter(filters).page(page).order(name: :asc))
    end

    def cpf_already_exist?(cpf)
      Contact.exists?(cpf: cpf)
    end

    def destroy(contact_id)
      Contact.destroy(contact_id)
    end

    def save!(contact)
      contact.address = Address.new(contact.address.attributes)
      model_contact = Contact.create!(contact.attributes)
      as_domain(model_contact)
    end

    def update(contact)
      ActiveRecord::Base.transaction do
        Contact.update(contact.id, contact.attributes_without_assoc)
        Address.update(contact.address.id, contact.address.attributes)
        true
      rescue ActiveRecord::RecordInvalid
        raise ActiveRecord::Rollback
      end
    end

    def as_domain(record)
      address = Domains::Models::Address.new(**record.address.attributes.symbolize_keys)
      Domains::Models::Contact.new(
        user: record.user, address: address, **record.attributes.symbolize_keys
      )
    end

    def as_domains(records)
      records.map { |record| as_domain(record) }
    end

    private_methods %i[as_domain as_domains]
  end
end
