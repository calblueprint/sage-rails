require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SageRails
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true

    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Load all models recursively (in subfolders) - screw namespacing
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    # Load all serializers recursively (in subfolders) - screw namespacing
    config.autoload_paths += Dir[Rails.root.join("app", "serializers", "{**}")]

    # Load all jobs recursively (in subfolders) - screw namespacing
    config.autoload_paths += Dir[Rails.root.join("app", "jobs", "{**}")]

    # Load all tasks recursively (in subfolders) - screw namespacing
    config.autoload_paths += Dir[Rails.root.join("app", "tasks", "{**}")]
  end
end
