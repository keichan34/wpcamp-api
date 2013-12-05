source 'https://rubygems.org'

ruby '2.1.0', engine: 'rbx', engine_version: '2.2.1'

platforms :rbx do
  gem "rubysl", "~> 2.0"
  gem 'racc'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.1'

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
  gem 'turbolinks'

  gem 'asset_sync'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'puma'

gem 'devise', '~> 3.1.1'

gem 'slim'
gem 'bootstrap-sass', '~> 3.0.1.0.rc'

gem 'newrelic_rpm'

gem 'dalli'

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
end
