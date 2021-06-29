ENV['RAILS_ENV'] ||= 'test'

require 'cucumber/rails'
require 'rails'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'chronic'
require 'cpf_faker'
require 'faker'
require 'ffaker'
require 'report_builder'
require 'site_prism'
require 'pry'
$LOAD_PATH.unshift Rails.root.join('spec').to_s
require './spec/rails_helper'

Capybara.configure do |config|
  config.default_driver = ENV['CUCUMBER_HEADLESS'].present? ? :selenium_chrome_headless : :selenium_chrome
  config.asset_host = 'http://127.0.0.1:3000'
  Capybara.page.driver.browser.manage.window.maximize
end
