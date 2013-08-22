source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'annotate'
gem 'bootstrap_form'
gem 'fabrication'
gem 'thin'
gem "capybara-email"
gem 'sidekiq'
gem 'unicorn'
gem 'carrierwave'
gem "fog", "~> 1.3.1"
gem 'mini_magick'
gem 'figaro'
gem 'stripe'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :development, :test do
  gem "rspec-rails", "~> 2.13.0"
  gem "factory_girl_rails", "~> 4.2.1"
end

group :test do
  gem "faker", "~> 1.1.2"
  gem "capybara"
  gem "database_cleaner", "~> 0.9.1"
  gem "launchy", "~> 2.2.0"
  gem "shoulda-matchers"
  gem 'vcr'
  gem 'webmock', '1.11.0'
end

group :production do
  gem 'pg'
end

gem 'jquery-rails'
