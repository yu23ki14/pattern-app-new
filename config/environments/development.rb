Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  
  # action mailar
  config.action_mailer.default_url_options = {host: 'service-test-pl-yu23ki14.c9users.io'}

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  
  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  #mailer
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    #:enable_starttls_auto => false,
    :address => 'smtp.gmail.com',
    #:address => 'localhost', for mailcatcher
    :port => 587,
    #:port => 1025, for mailcatcher
    :domain => 'gmail.com',
    :authentication => 'plain',
    :user_name => ENV['MAILER_USER_ID'],
    :password => ENV['MAILER_PASSWORD'],
    :enable_starttls_auto => true
  }

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.after_initialize do
    Bullet.enable = true # Bulletプラグインを有効
    Bullet.alert = true # JavaScriptでの通知
    Bullet.bullet_logger = false # log/bullet.logへの出力
    Bullet.console = false # ブラウザのコンソールログに記録
    Bullet.rails_logger = false # Railsログに出力
  end
end
