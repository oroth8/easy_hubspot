# frozen_string_literal: true

require 'spec_helper'
require 'generator_spec'

RSpec.describe EasyHubspot::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../tmp', __dir__)
  arguments %w[something]

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates a test initialize file' do
    assert_file 'config/initializers/easy_hubspot.rb', /EasyHubspot.config do |config|/
  end
end
