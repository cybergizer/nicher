source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'ancestry'
gem 'bootstrap-will_paginate'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'slim'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'devise'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'file_validators'
gem 'fog-aws'
gem 'mini_magick'
gem 'carrierwave'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'rubocop', '~> 0.54.0'
gem 'will_paginate'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'dotenv-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'paranoia', '~> 2.2'
gem 'audited', '~> 4.7'

group :development, :test do
  gem 'pry'
  gem 'bullet'
  gem 'brakeman'
  gem 'rack-mini-profiler', require: false
end

source 'https://rails-assets.org' do
  gem 'rails-assets-adminbsb-materialdesign'
  gem 'rails-assets-waves'
end
gem 'sweetalert-rails'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'reek', '>= 5.0'
  gem 'simplecov'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Rails Admin panel
gem 'rails_admin'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-yandex'
gem 'omniauth-google-oauth2'
