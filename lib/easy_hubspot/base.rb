require 'httparty'
require 'json'
require 'uri'

module EasyHubspot
  # class EasyHubspot::Base
  class Base
    include HTTParty

    def initialize(access_token:)
      @access_token = access_token
    end

    attr_accessor :access_token

    BASE_URI = 'https://api.hubapi.com'.freeze

    def headers
      { "Content-Type": 'application/json',
        "Authorization": "Bearer #{access_token}" }
    end

    def parse_response(response)
      JSON.parse response, symbolize_names: true
    end

    def email?(string)
      URI::MailTo::EMAIL_REGEXP.match?(string)
    end
  end
end
