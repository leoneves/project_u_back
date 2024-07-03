# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api/v1' do
    devise_for :users,
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'api/v1/sessions',
                 registrations: 'api/v1/registrations',
                 passwords: 'api/v1/passwords'
               },
               defaults: { format: :json }
  end
end
