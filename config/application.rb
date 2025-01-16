require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PSCodeAcademy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Load the view component previews
    config.view_component.preview_paths << "#{Rails.root}/spec/components/previews"
    config.view_component.default_preview_layout = "application"
    config.view_component.generate.stimulus_controller = true
    config.autoload_paths << Rails.root.join('app/services')
  end
end
