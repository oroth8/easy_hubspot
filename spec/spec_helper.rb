# frozen_string_literal: true

require 'simplecov'
require 'not_so_easy_hubspot'
require 'webmock/rspec'
require 'capybara/rspec'
require 'helper'

# For send test reports to Code Climate
if ENV.fetch('COVERAGE', false)
  SimpleCov.start do
    minimum_coverage 90
    maximum_coverage_drop 2
  end
end

require File.expand_path 'lib/not_so_easy_hubspot'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Helper
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
