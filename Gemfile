source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'rails-i18n', '~> 4.0.3'
gem 'devise-i18n'
gem 'bootstrap-sass', '3.1.1.0' # TODO (using css @import syntax)
gem 'bcrypt-ruby', '~> 3.0.1' # TODO
gem 'sass-rails', '~> 4.0.5' # TODO
gem 'uglifier', '~> 2.7'
gem 'coffee-rails', '~> 4.0.0' # TODO
gem 'jquery-rails'

gem 'datejs-rails' # syntactic sugar for JavaScript Date
gem 'chart-js-rails' # js charts api
gem 'mediaelement_rails' # js music and video player
gem 'prawn-rails' # pdf generation

gem 'rails_12factor', group: :production # gem for heroku

gem "nested_form" # nested form support

gem "thin" # webserver
gem 'aws-sdk'

gem 'jquery-ui-rails'
gem 'jquery.fileupload-rails'

gem "faye-rails" # websockets
gem "private_pub"

gem 'jbuilder', '~> 1.2' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder


gem 'devise' # user management
gem 'devise_invitable' # user invitations
gem 'cancan' # authorization

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
 	gem 'rake'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'irbtools', require: 'binding.repl'

  gem 'rspec-rails', '~> 2.0'
  gem 'test-unit' # TODO remove, see https://github.com/rspec/rspec-rails/issues/1273
	gem 'capybara', '~> 2.4'
  # gem 'capybara-webkit'
  gem 'capybara-screenshot'
	gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
end

group :test do
	gem 'libnotify', '0.8.0'
  gem 'simplecov', require: false # test coverage report
end

# gem 'newrelic_rpm' # performance monitoring
# gem 'therubyracer', platforms: :ruby
