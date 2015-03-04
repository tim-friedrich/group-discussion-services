source 'https://rubygems.org'
ruby '2.2.0'


# # #
# GENERAL

gem 'rails', '4.2.0'
gem "thin" # webserver
gem 'pg'
gem 'rails-i18n', '~> 4.0.3'
gem 'bcrypt', '~> 3.1.9'
gem 'devise-i18n'
gem 'jbuilder', '~> 1.2' # json apis https://github.com/rails/jbuilder
gem 'active_model_serializers', git: "https://github.com/rails-api/active_model_serializers"
gem 'rake'
gem 'dotenv'
gem "paperclip"
gem 'will_paginate-bootstrap'
gem 'will-paginate-i18n'
gem 'prawn-rails'        # pdf generation
gem 'sdoc', group: 'doc', require: false
gem 'phantomjs'
# gem 'therubyracer', platforms: :ruby


# # #
# AUTH

gem 'devise' # user management
gem 'devise_invitable' # user invitations
gem 'cancan' # authorization


# # #
# WEBSOCKETS

gem "private_pub"
gem 'faye-rails' # necessary for faye.js in asset pipline


# # #
# ASSETS

gem 'sass-rails', '~> 4.0.5' # TODO
gem 'bootstrap-sass', '3.1.1.0' # TODO (using css @import syntax)
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '~> 2.7.0'


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

gem 'whiskey_disk', github: 'johnae/whiskey_disk', branch: 'develop'
gem 'exception_notification'

group :production do
  gem 'rails_12factor' # heroku
  # gem 'newrelic_rpm' # performance monitoring
end


# # #
# DEVELOMPENT / TEST

group :development, :test do
  gem 'database_cleaner'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'irbtools', require: 'binding.repl'

  gem 'rspec-rails', '~> 3.1'
  gem 'capybara', '~> 2.4'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
end

group :test do
  gem 'libnotify', '0.8.0'
  # gem 'simplecov', require: false # test coverage report
end
