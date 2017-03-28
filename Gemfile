source "https://rubygems.org"

ruby "2.3.1"

gem "administrate", "~> 0.1.4"
gem "autoprefixer-rails"
gem "delayed_job_active_record"
gem 'devise'
gem "flutie"
gem "high_voltage"
gem "honeybadger"
gem "jquery-rails"
gem "newrelic_rpm", ">= 3.9.8"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "sprockets", "~> 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem 'rubysl-securerandom', '~> 2.0'

group :development do
  gem "quiet_assets"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
  gem 'rails-erd'
end

group :development, :test do
  # gem "awesome_print"
  # gem "bullet"
  # gem "bundler-audit", ">= 0.5.0", require: false
  # gem "dotenv-rails"
  # gem "pry-byebug"
  # gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  # gem "database_cleaner"
  # gem "formulaic"
  # gem "launchy"
  # gem "shoulda-matchers"
  # gem "simplecov", require: false
  # gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rails_stdout_logging"
  gem "rack-timeout"
end

group :test, :development do
  # gem 'pronto'
  # gem 'pronto-rubocop'
  # gem 'pronto-reek'
  # gem 'pronto-rails_best_practices'
end

# These are the gems that include the Pronto tool in our application. Adding them to the Gemfile adds them to my application's list of dependencies. But I'll now need to run `bundle install` to actually install them.

gem "rubyXL", require: false
gem 'pg_search'