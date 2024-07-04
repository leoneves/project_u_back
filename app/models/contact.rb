# frozen_string_literal: true

class Contact < ApplicationRecord
  has_one :address, dependent: :restrict_with_error
  belongs_to :user
end
