source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.0.13'
gem 'pg'
gem 'rails-i18n', '~> 4.0.3'
gem 'devise-i18n'
gem 'bootstrap-sass', '3.1.1.0' # TODO (using css @import syntax)
gem 'bcrypt-ruby', '~> 3.0.1' # TODO
gem 'sass-rails', '~> 4.0.0' # TODO
gem 'uglifier', '>= 1.3.0' # TODO
gem 'coffee-rails', '~> 4.0.0' # TODO

#syntactic sugar for JavaScript Date
gem 'datejs-rails'

#js charts api
gem 'chart-js-rails'

#gem for js musik and video player
gem 'mediaelement_rails'

#gem for pdf generation
gem 'prawn-rails'

#gem for heroku
gem 'rails_12factor', group: :production

# nested form support
gem "nested_form"

#webserver
gem "thin"

gem 'aws-sdk'

gem 'jquery-ui-rails'
gem 'jquery.fileupload-rails'

#gem for websockets
gem "faye-rails"
gem "private_pub"

# gem for newrelic (performance monitoring)
# gem 'newrelic_rpm'

# TODO remove turbolinks
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# gem for user management & for user invitations
gem 'devise'
gem 'devise_invitable'

#Authorization Gem
gem 'cancan'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 2.0'
	gem 'cucumber-rails', '1.2.1', :require => false
 	gem 'rake'
	gem 'capybara', '1.1.2' # TODO
	gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', :require => nil

  # TODO remove guard/spork
 	#gem for automated tests
  gem 'guard-rspec', '2.5.0'

  #gems for faster test runs
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
end

group :test do
	gem 'libnotify', '0.8.0'
end

#gem for test coverage report
gem 'simplecov', :require => false, :group => :test
