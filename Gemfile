# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

# Database logic
gem 'aasm'
gem 'pg'
gem 'scenic'

# FTS
gem 'pg_search'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
gem 'webpacker'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# User Auth
gem 'devise'
gem 'pundit'

# Background jobs
gem 'sidekiq', '~> 6.1'
gem 'sidekiq-batch', '~> 0.1.6'

gem 'carrierwave'
gem 'docx'

group :development, :test do
  gem 'pry-rails'

  # Audit
  gem 'annotate'
  gem 'brakeman'
  gem 'bullet'
  gem 'bundler-audit'
  gem 'database_consistency'
  gem 'factory_bot_rails'
  gem 'lefthook'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'listen', '~> 3.1.5'
end

group :test do
  gem 'capybara'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  # gem 'selenium-webdriver'
  # gem 'webdrivers'
end
