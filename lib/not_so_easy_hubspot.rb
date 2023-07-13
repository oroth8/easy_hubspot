# frozen_string_literal: true

require 'not_so_easy_hubspot/base'
require 'not_so_easy_hubspot/client'
require 'not_so_easy_hubspot/contact'
require 'not_so_easy_hubspot/deal'
require 'not_so_easy_hubspot/version'
require 'not_so_easy_hubspot/exceptions'

require 'httparty'
require 'json'
require 'uri'

# NotSoEasyHubspot
module NotSoEasyHubspot
  class << self
    attr_accessor :configuration
  end

  def self.config
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # NotSoEasyHubspot::Configuration
  class Configuration
    attr_accessor :access_token, :base_url

    def initialize
      @access_token = ''
      @base_url = 'https://api.hubapi.com/'
    end
  end
end
