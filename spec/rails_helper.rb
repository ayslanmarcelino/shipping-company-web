# frozen_string_literal: true

require './spec/spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'paper_trail/frameworks/rspec'
require 'rspec/retry'

if %w[1 true t].include?(ENV['CI'])
  Selenium::WebDriver::Chrome::Service.driver_path = '/usr/local/bin/chromedriver'
else
  require 'webdrivers'
  require 'webdrivers/chromedriver'
end

Dir[Rails.root.join('spec/support/**/*.rb'), Rails.root.join('spec/fixtures/**/*.rb')].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include ActiveJob::TestHelper, type: :job

  config.render_views
  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.before(:each, js: true) do
    Capybara.page.driver.browser.manage.window.resize_to(1280, 720)
  end

  config.after do
    travel_back
  end

  config.before :suite do
    Warden.test_mode!
    DatabaseRewinder.clean_all
    Testing.completed_client
    Testing.charging_bank_account
    build_integrator_connection
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.verbose_retry = true
  config.default_retry_count = 2
  config.exceptions_to_retry = [Net::ReadTimeout]
end

Capybara.configure do |config|
  config.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
  config.javascript_driver = :selenium_chrome_headless
  config.asset_host = 'http://127.0.0.1:3000'
end

def build_integrator_connection
  SocopaIntegrator::ApplicationRecord.establish_connection(adapter: 'sqlite3', database: ':memory:')
  SocopaIntegratorPlus::Stock.using_attributes.each do |table, attributes|
    SocopaIntegrator::ApplicationRecord.connection.create_table "socopa_integrator_#{table.to_s.pluralize}" do |t|
      attributes.except(:id).each_key { |attr_name| t.string attr_name }
    end
  end
end

def drop_integrator_tables
  SocopaIntegratorPlus::Stock.using_attributes.each_key do |table|
    SocopaIntegrator::ApplicationRecord.connection.drop_table "socopa_integrator_#{table.to_s.pluralize}"
  end
end
