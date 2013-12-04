source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'bootstrap-sass', '>= 3.0'

gem 'bcrypt-ruby', '~> 3.0.1'

#real time support for chat
gem 'faye'

#thin server which is used by faye
gem 'thin'

#gem for private channels for faye (security measure)
gem 'private_pub', :git => 'git://github.com/ryanb/private_pub.git'

# Use sqlite3 as the database for Active Record
gem 'pg'

#gem for heroku
gem  'rails_12factor'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  	gem 'rspec-rails', '~> 2.0'
	gem 'cucumber-rails', '1.2.1', :require => false
 	gem 'rake'
	gem 'capybara', '1.1.2'
  	#gem 'codeclimate-test-reporter', :require => nil
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
