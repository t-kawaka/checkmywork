require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Checkmywork
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.load_defaults 5.2
    I18n.config.available_locales = :ja
  end
end
