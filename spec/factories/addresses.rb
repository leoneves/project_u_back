# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    cep { 'MyString' }
    latitude { '9.99' }
    longitude { '9.99' }
    address { 'MyText' }
    address_complement { 'MyText' }
    contact { nil }
  end
end
