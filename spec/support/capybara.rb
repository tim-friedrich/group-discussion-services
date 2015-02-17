RSpec.configure do |config|
  require 'capybara/rails'
  require 'capybara-screenshot/rspec'
  Capybara.javascript_driver = :webkit

  config.include Capybara::DSL

  # class ActionDispatch::IntegrationTest
  #   include Capybara::DSL
  #   def teardown
  #     Capybara.reset_sessions!
  #     Capybara.use_default_driver
  #   end
  # end


  # config.include Devise::TestHelpers, type: :feature
  config.include Warden::Test::Helpers
  Warden.test_mode!
end
