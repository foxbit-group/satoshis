# frozen_string_literal: true

require "bundler/setup"
require "pry-byebug"
require "satoshis"
require "simplecov"
require "simplecov-console"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start
