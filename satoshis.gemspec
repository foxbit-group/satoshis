# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "satoshis/version"

Gem::Specification.new do |spec|
  spec.name          = "satoshis"
  spec.version       = Satoshis::VERSION
  spec.authors       = ["Bruno Soares"]
  spec.email         = ["bruno@bsoares.com"]

  spec.summary     = "Satoshis"
  spec.description = "A Ruby gem to manipulate Bitcoin money without loss of precision."
  spec.homepage    = "https://github.com/bsoares/satoshis"
  spec.license     = "MIT"

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",        "~> 1.16"
  spec.add_development_dependency "pry-byebug",     "~> 3.6"
  spec.add_development_dependency "rake",           "~> 10.0"
  spec.add_development_dependency "rspec",          "~> 3.0"
  spec.add_development_dependency "rubocop",        "~> 0.53"
  spec.add_development_dependency "rubocop-github", "~> 0.10"
  spec.add_development_dependency "rubocop-rspec",  "~> 1.24"
end
