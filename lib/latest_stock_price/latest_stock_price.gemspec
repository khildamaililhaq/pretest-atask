# frozen_string_literal: true

require_relative "lib/latest_stock_price/version"

Gem::Specification.new do |spec|
  spec.name = "latest_stock_price"
  spec.version = LatestStockPrice::VERSION
  spec.authors = "Khilda Maililhaq"
  spec.email = "khilda.maililhaq@gmail.com"

  spec.summary = "A gem for atask pretest"
  spec.description = "A gem for atask pretest, with integration to rapid api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
