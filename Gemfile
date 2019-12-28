source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
# gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'interactor'
gem 'decent_exposure'

gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop-rails'
  gem 'rubocop'
  gem 'fasterer'
  gem 'rails_best_practices'
end
