# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { "My name #{('a'..'z').to_a[rand(26)]}" }
    cpf { Random.new_seed }
    phone { 'MyString' }
    user { nil }

    trait :with_address do
      after :build do |instance|
        instance.address = create(:address, contact: instance)
      end
    end
  end
end
