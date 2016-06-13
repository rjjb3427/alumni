require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require 'meetup_client'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Alumni
  class Application < Rails::Application
    config.middleware.use Rack::Deflater

    MeetupClient.configure do |config|
      config.api_key = ENV['MEETUP_API_KEY']
    end

    config.i18n.enforce_available_locales = true
    config.embed_authenticity_token_in_remote_forms = true

    config.generators do |generate|
      generate.helper true
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      # generate.test_framework :rspec
      generate.view_specs false
    end

    config.action_controller.action_on_unpermitted_parameters = :raise
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.after_initialize do |app|
      app.routes.default_url_options = app.config.action_mailer.default_url_options
    end

    config.assets.image_optim = false

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.active_job.queue_adapter = :sidekiq

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # config.react.addons = true

    # https://babeljs.io/docs/advanced/transformers/
    config.react.jsx_transform_options = {
      blacklist: ['spec.functionName', 'validation.react'],
      optional: ["es6.arrowFunctions", "es6.classes", "es7.classProperties"]
    }

    # API
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '/api/*', :headers => :any, methods: [:get]
      end
    end
  end
end
