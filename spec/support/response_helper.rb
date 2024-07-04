# frozen_string_literal: true

module Response
  module JsonHelpers
    def parsed_body
      return JSON.parse(response.body, symbolize_names: true) unless [204, 404].include?(response.status)

      response
    end
  end
end
