Tilannekuva::Application.configure do
  config.use_basic_auth = true
  config.basic_auth_user = "risti"
  config.basic_auth_password = "sparra"

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  config.serve_static_assets = true

  config.action_mailer.default_url_options = { host: 'tilannekuva.spr-tapiola.org', port: 80 }

end
