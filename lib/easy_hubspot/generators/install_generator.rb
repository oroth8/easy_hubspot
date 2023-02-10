# frozen_string_literal: true

require 'rails/generators'

module EasyHubspot
  module Generators
    # InstallGenerator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      desc 'This generator creates an initializer file at config/initializers'
      def copy_initializer
        copy_file 'easy_hubspot.rb', 'config/initializers/easy_hubspot.rb'
      end
    end
  end
end
