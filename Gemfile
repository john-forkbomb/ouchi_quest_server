source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.1'
gem 'ridgepole'
gem 'rspec'
gem 'rubocop'
gem 'rack-cors'

# DB
gem 'pg'
gem 'redis', '~> 4.0'

# auth
# gem 'omniauth-twitter'
# gem 'sorcery'
gem 'devise'
gem 'jwt'

# serializer
gem 'fast_jsonapi'

# model
gem 'enumerize'

# server
gem 'puma', '~> 3.12'

gem 'uglifier', '>= 1.3.0'

gem 'turbolinks', '~> 5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# use AWS S3
gem 'aws-sdk'
gem 'aws-sdk-s3'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rails-erd'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
