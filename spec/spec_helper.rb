ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require File.expand_path("../../db/seeds", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
# require 'simplecov'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Rails.application.routes.default_url_options[:host] = 'localhost:5000'
# ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # config.mock_with :rr
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  # - - -

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

