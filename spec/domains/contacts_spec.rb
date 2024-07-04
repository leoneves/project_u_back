# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domains::Contacts do
  describe '.create_contact' do
    subject { described_class.create_contact(**params) }

    context 'with valid params' do
      let(:user) { create(:user) }
      let(:address) { Domains::Models::Address.new(**hash_to_sym(build(:address).attributes)) }
      let(:params) do
        {
          name: 'My Name', cpf: '12712345890', phone: '21994587125',
          user: user, address: address,
          user_id: user.id, address_id: address.id
        }
      end

      it { is_expected.to be_success }
    end

    context 'without any' do
      let(:params) { { user: nil, address: nil } }

      it { is_expected.not_to be_success }
    end
  end
end
