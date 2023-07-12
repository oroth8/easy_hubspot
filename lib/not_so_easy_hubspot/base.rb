# frozen_string_literal: true

module NotSoEasyHubspot
  # class NotSoEasyHubspot::Base
  class Base
    class << self
      def headers
        { "Content-Type" => 'application/json',
          "Authorization" => "Bearer #{NotSoEasyHubspot.configuration.access_token}" }
      end

      def email?(string)
        URI::MailTo::EMAIL_REGEXP.match?(string)
      end
    end
  end
end
