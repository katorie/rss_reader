require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RssReader
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    I18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
  end
end
