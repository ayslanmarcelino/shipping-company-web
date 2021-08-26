require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_storage/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'simple_enum/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PontualWeb
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.system_tests = nil
    config.time_zone = 'America/Maceio'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'
    config.exceptions_app = routes
  end
end
