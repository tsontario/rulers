# frozen_string_literal: true

require_relative "lib/rulers/version"

Gem::Specification.new do |spec|
  spec.name          = "rulers"
  spec.version       = Rulers::VERSION
  spec.authors       = ["Timothy Smith"]
  spec.email         = ["tsontario@gmail.com"]
  spec.license = "MIT"

  spec.homepage = "https://github.com/tsontario/rulers"
  spec.summary = "A rack-based web framework based on the book Rebuilding Rails"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["source_code_uri"] = "https://github.com/tsontario/rulers"
  spec.metadata["changelog_uri"] = "https://github.com/tsontario/rulers/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|rulers.*\.gem)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("rack", "~>2")
  spec.add_dependency("erubis", "~>2")
  spec.add_development_dependency("byebug")
  spec.add_development_dependency("rack-test", "~> 1.1")
  spec.add_development_dependency("minitest", "~> 5.14")
  spec.add_development_dependency("rubocop-shopify", "~>2.1")

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
