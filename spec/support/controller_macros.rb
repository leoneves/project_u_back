# frozen_string_literal: true

module ControllerMacros
  def login_user
    before do
      user = FactoryBot.create(:user)
      sign_in user
    end
  end
end
