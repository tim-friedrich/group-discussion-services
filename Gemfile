source 'https://rubygems.org'
ruby '2.2.1'


# # #
# GENERAL

gem 'rails', '4.2.1'
gem 'dotenv-rails'
gem 'rake'
gem 'thin'
gem 'pg'
gem 'rails-i18n'
gem 'bcrypt', '~> 3.1.10'
gem 'devise-i18n'
gem "paperclip"
gem "active_decorator"
gem 'will_paginate-bootstrap'
gem 'will-paginate-i18n'
gem 'prawn-rails'
gem 'prawn', '~> 2.0', '>= 2.0.1'
gem 'phantomjs'
gem 'country_select'


# # #
# ADMIN

gem 'rails_admin'


# # #
# AUTH

gem 'devise' # user management
gem 'devise_invitable' # user invitations
gem 'cancancan' # authorization


# # #
# WEBSOCKETS

gem "private_pub"
gem 'faye-rails' # necessary for faye.js in asset pipline


# # #
# JSON

gem 'jbuilder', '~> 2.2'
gem 'active_model_serializers', git: "https://github.com/rails-api/active_model_serializers"


# # #
# ASSETS

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'coffee-rails', '~> 4.1'
gem 'uglifier', '~> 2.7'


# # #
# JAVASCRIPT

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery.fileupload-rails'
gem "nested_form" # jquery
gem 'datejs-rails'  # syntactic sugar for JavaScript Date
gem 'mediaelement_rails' # js music and video player


# # #
# DEPLOYMENT / PRODUCTION

gem 'whiskey_disk', git: 'https://github.com/johnae/whiskey_disk', branch: 'develop'
gem 'exception_notification'

group :production do
  gem 'rails_12factor'
end


# # #
# DEVELOMPENT / TEST

group :development, :test do
  gem 'database_cleaner'
  gem 'lol_dba'
  gem 'byebug'
  gem 'irbtools', '~> 2.0', require: 'irbtools/binding'
  # gem 'web-console', '~> 2.0'
  gem 'rspec-rails', '~> 3.2'
  gem 'clipboard_formatter'
  gem 'capybara'
  # gem 'capybara-puma'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'poltergeist'
  gem 'capybara-screenshot'
  # gem 'capybara-slow_finder_errors'
  gem 'factory_girl_rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'libnotify'
  gem 'quiet_assets'
end


# # #
# If node is not installed

# gem 'therubyracer', platforms: :ruby
