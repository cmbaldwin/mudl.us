require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'dotenv-rails'
Dotenv::Railtie.load

module MudlUs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Single dyno background job adapter (OK for single user hobby project)
    config.active_job.queue_adapter = :async
	config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new \
		min_threads: 1,
		max_threads: 2 * Concurrent.processor_count,
		idletime: 600.seconds


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
