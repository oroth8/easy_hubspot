# frozen_string_literal: true

require 'easy_hubspot/base'
require 'easy_hubspot/client'
require 'easy_hubspot/contact'
require 'easy_hubspot/company'
require 'easy_hubspot/deal'
require 'easy_hubspot/product'
require 'easy_hubspot/line_item'
require 'easy_hubspot/version'
require 'easy_hubspot/generators/install_generator'
require 'easy_hubspot/exceptions'

require 'httparty'
require 'json'
require 'uri'

# EasyHubspot
module EasyHubspot
  class << self
    attr_accessor :configuration
  end

  def self.config
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # EasyHubspot::Configuration
  class Configuration
    attr_accessor :access_token, :base_url

    def initialize
      @access_token = ''
      @base_url = 'https://api.hubapi.com/'
    end
  end
end
