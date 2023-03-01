# frozen_string_literal: true

require_relative 'lib/easy_hubspot/version'

Gem::Specification.new do |spec|
  spec.name = 'easy_hubspot'
  spec.version = EasyHubspot::VERSION
  spec.authors = ['Owen Roth']
  spec.email = ['rothowen27@gmail.com']

  spec.summary = 'An easier way to integrate with the Hubspot API'
  spec.description = 'This gem is designed to make it easier to integrate with the Hubspot API'
  spec.homepage = 'https://github.com/oroth8/easy-hubspot'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/oroth8/easy-hubspot/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # dependencies
  spec.add_dependency 'httparty', '~> 0.21.0'

  # development dependencies
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'capybara', '~> 3.36'
  spec.add_development_dependency 'generator_spec', '~> 0.9.4'
  spec.add_development_dependency 'pry', '~> 0.14.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.12.0'
  spec.add_development_dependency 'rubocop', '~> 1.2'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.18.1'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
  spec.add_development_dependency 'webmock', '~> 3.14'
end
