# frozen_string_literal: true

require_relative 'lib/easy_hubspot/version'

Gem::Specification.new do |spec|
  spec.name = 'easy_hubspot'
  spec.version = EasyHubspot::VERSION
  spec.authors = ['Owen Roth']
  spec.email = ['rothowen27@gmail.com']

  spec.summary = 'An easier way to integrate with the Hubspot API'
  spec.description = 'This gem is designed to make it easier to integrate with the Hubspot API'
  # spec.homepage = "Put your gem's website or public repo URL here."
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

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

  # runtime dependencies
  spec.add_runtime_dependency 'json', '~> 2.6.0'
  spec.add_runtime_dependency 'uri', '~> 0.12.0'

  # dependencies
  spec.add_dependency 'httparty', '~> 0.17.3'

  # development dependencies
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.2'
end
