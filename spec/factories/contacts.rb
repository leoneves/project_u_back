# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { 'MyString' }
    cpf { 'MyString' }
    phone { 'MyString' }
    address { nil }
    user { nil }
  end
end
