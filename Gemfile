# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

# Database logic
gem 'aasm'
gem 'pg'

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

group :development, :test do
  gem 'pry-rails'

  # Audit
  gem 'annotate'
  gem 'brakeman'
  gem 'bullet'
  gem 'bundler-audit'
  gem 'database_consistency'
  gem 'lefthook'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen', '~> 3.1.5'
end

group :test do
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', '~> 5.0'
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # gem 'webdrivers'
end
