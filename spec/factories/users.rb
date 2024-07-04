# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'My Name' }
    email { "my_email#{Random.rand(10_000)}@email.com" }
    password { '123456' }
  end
end
