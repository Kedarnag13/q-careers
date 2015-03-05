source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Database
gem 'pg'

# Development Server
gem 'thin'

# API / JSON Lib - For communicating with Q-Auth Server
gem 'typhoeus'

# Image Upload and manipulations
gem 'carrierwave'
gem 'fog'
gem 'rmagick', :require => 'RMagick'
gem 'jquery-fileupload-rails'

gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Code Climate
gem "codeclimate-test-reporter", group: :test, require: nil

gem 'q_auth_ruby_client', '~> 0.0.8'
#gem 'q_auth_ruby_client', path: "/Users/kvarma/Projects/QwinixLabs/q-apps/q_auth_ruby_client"
gem 'poodle-rb', '~> 0.1.4'
#gem 'poodle-rb', path: "/Users/kvarma/Projects/QwinixLabs/q-apps/poodle"

# Poodle Dependencies
gem "handy-css-rails", "0.0.7"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "bootstrap-datepicker-rails"
gem "jquery-validation-rails"
gem "rolify"
gem "mina", git: "git://github.com/nadarei/mina.git"


# Use Capistrano for deployment
group :development do
  gem "parallel_tests"
  gem 'railroady'
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  #gem 'capistrano-console'
  #gem "capistrano-ext"
  #gem "capistrano-deploytags"
  #gem "brakeman", :require => false
  #gem "hirb"
end

group :development, :test do
  gem "factory_girl_rails"
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  #gem 'pry-debugger'
  #gem "spork", "~> 1.0rc"
  #gem "better_errors"
  #gem "binding_of_caller"
  gem 'rspec-rails', '~> 3.0' # Needed for rake stats to calculate test coverage
  #gem "awesome_print"
  gem "quiet_assets"
end

#gem 'rails_12factor', group: :production

group :it, :staging, :development, :test, :uat, :production do
  gem 'ruby-progressbar'
  gem "colorize"
end

group :test do
  gem "shoulda"
  #gem 'cucumber-rails', :require => false
  #gem 'cucumber-websteps'
  #gem 'pickle'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #gem 'rspec', '~> 3.2.0'
  #gem 'rspec-rails', '~> 3.0'
end

