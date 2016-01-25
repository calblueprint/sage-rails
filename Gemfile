source "https://rubygems.org"
ruby "2.2.0"

# Core gems
gem "rails", "4.2.0"
gem "thin"
gem "pg"
gem "figaro"

# Components
gem "cancancan"
gem "devise"
gem "ffaker"
gem "recipient_interceptor"
gem "active_model_serializers", "0.9.3"

# Error logging - requires setup with service
# gem "rollbar"

# Validating Dates
gem "date_validator"

# Scoping query parameters
gem "has_scope"

# Uploads
gem "carrierwave"
gem "carrierwave-aws"

# Background jobs
gem 'whenever', require: false
gem 'sucker_punch'

group :development do
  gem "annotate"
  gem "quiet_assets"
  gem "spring"
  gem "spring-commands-rspec"
  gem "rubocop"
  gem "guard-rubocop"
  gem "guard-livereload"
  gem "i18n-tasks"
end

group :development, :test do
  gem "awesome_print"
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.1.0"
  gem "factory_girl_rails"
end

group :test do
  gem "shoulda-matchers", require: false
  gem "database_cleaner"
  gem "capybara"
  gem "launchy"
  gem "guard-rspec"

  gem "codeclimate-test-reporter", require: nil
end

group :staging, :production do
  gem "rails_12factor"

  # Analytics - requires setup
  gem "newrelic_rpm"
end
