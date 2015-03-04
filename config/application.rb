require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module GDS
  class Application < Rails::Application
    require 'survey_analyzer'
    require 'chart_image'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    I18n.config.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :de
    config.time_zone = 'Berlin'

    config.middleware.delete Rack::Lock

    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    Dir.glob("#{Rails.root}/app/assets/images/**").each do |path|
      config.assets.paths << path
    end

    ActiveSupport.escape_html_entities_in_json = true
  end
end
