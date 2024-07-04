# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Contacts', type: :request do
  login_user

  describe 'GET /index' do
    subject do
      get api_v1_contacts_path, params: params
      parsed_body
    end

    context 'without filters' do
      before { create_list(:contact, 2, :with_address, user: create(:user)) }

      let(:params) { nil }

      it { is_expected.to satisfy { |res| res.size == 2 && res.is_a?(Array) } }
    end

    context 'with filter by name' do
      before do
        create(:contact, :with_address, name: 'Leo Neves', user: create(:user))
        create(:contact, :with_address, name: 'Caetano Neves', user: create(:user))
      end

      let(:params) { { name: 'leo' } }

      it { is_expected.to satisfy { |res| res.size == 1 && res.is_a?(Array) } }
    end

    context 'with filter by cpf' do
      context 'with cpf exactly' do
        before do
          create(:contact, :with_address, cpf: '09944011790', user: create(:user))
          create(:contact, :with_address, cpf: '01128032740', user: create(:user))
        end

        let(:params) { { cpf: '09944011790' } }

        it { is_expected.to satisfy { |res| res.size == 1 && res.is_a?(Array) } }
      end

      context 'with part of cpf' do
        before do
          create(:contact, :with_address, cpf: '09944011790', user: create(:user))
        end

        let(:params) { { cpf: '099' } }

        it { is_expected.to have_http_status(:no_content) }
      end
    end
  end
end
