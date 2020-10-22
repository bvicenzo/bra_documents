# frozen_string_literal: true

require 'bundler/setup'
require 'rspec/matchers/fail_matchers'
require 'bra_documents'
require 'bra_documents/testing/rspec'

RSpec.configure do |config|
  config.include RSpec::Matchers::FailMatchers
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
