# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'

gem 'active_model_serializers', '~> 0.10.0'
gem 'cpf_cnpj'
gem 'devise-jwt'
gem 'faraday'
gem 'kaminari'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'validators'

group :development, :test do
  gem 'database_cleaner-active_record'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rack-cors'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem 'letter_opener', group: :development
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
