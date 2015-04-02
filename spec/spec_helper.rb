ENV["RAILS_ENV"] ||= 'test'

require_relative "../config/environment"
require_relative "../db/seeds"

require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Rails.application.routes.default_url_options[:host] = 'localhost:5000'
# ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.include Devise::TestHelpers, type: :controller
  config.include Rails.application.routes.url_helpers
end

