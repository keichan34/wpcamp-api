source 'https://rubygems.org'

ruby '2.1.0'
# ruby '2.1.0', engine: 'rbx', engine_version: '2.2.1'

gem 'nokogiri'

platforms :rbx do
  gem "rubysl", "~> 2.0"
  gem 'racc'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

# Assets

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.0'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  # Use jquery as the JavaScript library
  gem 'jquery-rails'

  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  # gem 'turbolinks'

  gem 'js-routes'

  gem 'asset_sync'
  gem 'unf'

# Set the internal timezone to the user's timezone
gem 'browser-timezone-rails'
gem 'handlebars_assets'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# gem 'puma'
gem 'unicorn'

gem 'slim'
gem 'bootstrap-sass', '~> 3.0.3.0'

gem 'newrelic_rpm'

gem 'dalli'

gem 'thread'

gem 'rabl'
gem 'oj'

gem 'kaminari'

gem 'aws-sdk'
gem 'paperclip'

gem 'textacular', '~> 3.0'

# Parse Accept-Language:
gem 'http_accept_language'

gem 'devise', '~> 3.2.2'

gem "rails-settings-cached", "~> 0.3.1"

group :production do
  # For Heroku
  gem 'rails_12factor'
  gem 'memcachier'
end

group :development do
  gem 'quiet_assets'
  gem 'pry'
  gem 'foreman'
  gem 'dotenv-rails'
  gem 'byebug', platforms: :mri_20
end
