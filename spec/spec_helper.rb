# frozen_string_literal: true

require 'capybara/email/rspec'
require 'webmock/rspec'

if ENV['USE_SIMPLECOV']
  require 'simplecov'
  SimpleCov.profiles.define 'grafeno-cov' do
    load_profile 'rails'
    add_filter 'vendor'
    add_filter 'app/helpers'
    add_filter 'app/cells'
    add_filter 'lib'
    add_filter 'app/models/concerns'
    add_filter 'app/admin/active_admin'
  end
  SimpleCov.start 'grafeno-cov'
end

WebMock.disable_net_connect!(allow: [/127.0.0.1/, /chromedriver.storage.googleapis.com/])

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.max_formatted_output_length = 2000
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.example_status_persistence_file_path = 'tmp/rspec_examples.txt'
end
