require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Fbt11
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.available_locales = [:en]
  end
end
