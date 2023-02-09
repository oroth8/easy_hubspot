require "httparty"
require "pry"
require "json"

module EasyHubspot
  class Base
    include HTTParty

    def initialize(access_token:)
      @access_token = access_token
    end

    attr_accessor :access_token

    BASE_URI = 'https://api.hubapi.com'

    def headers
      { "Content-Type": 'application/json',
        "Authorization": "Bearer #{access_token}" }
    end

    def parse_response(response)
      JSON.parse response, symbolize_names: true
    end
  end
end
