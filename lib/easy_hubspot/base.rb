# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Base
  class Base
    class << self
      def headers
        { "Content-Type" => 'application/json',
          "Authorization" => "Bearer #{EasyHubspot.configuration.access_token}" }
      end

      def email?(string)
        URI::MailTo::EMAIL_REGEXP.match?(string)
      end
    end
  end
end
