# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# gem 'jbuilder', '~> 2.7'

gem 'bcrypt', '~> 3.1.7'
gem 'decent_exposure'
gem 'interactor'
gem 'jwt'
gem 'pundit'

gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem 'fasterer'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
