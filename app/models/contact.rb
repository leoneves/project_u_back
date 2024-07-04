# frozen_string_literal: true

class Contact < ApplicationRecord
  include Filterable

  has_one :address, dependent: :restrict_with_error
  belongs_to :user

  scope :user_id, ->(user_id) { where(user_id: user_id) }
  scope :name_scope, ->(name) { where('name ilike ?', "%#{name}%") }
  scope :cpf, ->(cpf) { where(cpf: cpf) }

  paginates_per 15
end
