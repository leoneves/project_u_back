# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'save' do
    subject { described_class.new(params) }

    context 'with all valid params' do
      let(:params) do
        { name: 'User 1', email: 'user1@gmail.com', password: '123456' }
      end

      it { is_expected.to be_valid }
    end
  end
end
