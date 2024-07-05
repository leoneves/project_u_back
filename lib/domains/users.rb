# frozen_string_literal: true

module Domains
  module Users
    extend Monads::ModulesResponse
    include Repositories

    module_function

    def delete_user(user_id)
      user = UserRepo.destroy(user_id)

      response(success: user.destroyed?, value: user)
    end
  end
end
