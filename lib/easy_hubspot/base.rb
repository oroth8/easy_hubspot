# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Base
  class Base
    class << self
      def headers(access_token = nil)
        { "Content-Type" => 'application/json',
          "Authorization" => "Bearer #{access_token || EasyHubspot.configuration.access_token}" }
      end

      def email?(string)
        URI::MailTo::EMAIL_REGEXP.match?(string)
      end
    end
  end
end
