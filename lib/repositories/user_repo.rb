# frozen_string_literal: true

module Repositories
  module UserRepo
    module_function

    def destroy(user_id)
      User.destroy(user_id)
    end
  end
end
