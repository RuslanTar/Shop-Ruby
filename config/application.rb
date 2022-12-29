# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # For version 1.1.0 and above of the `i18n` gem:
    config.i18n.fallbacks = { en: %i[en uk], uk: %i[uk en] }
    # Below version 1.1.0 of the `i18n` gem:
    # config.i18n.fallbacks = true
    config.i18n.default_locale = :uk
  end
end
