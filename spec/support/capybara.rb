RSpec.configure do |config|
  require 'capybara/rails'
  require 'capybara-screenshot/rspec'
  Capybara.javascript_driver = :webkit

  config.include Capybara::DSL
  Capybara.default_wait_time = 5

  #config.include Devise::TestHelpers, type: :feature
  config.include Warden::Test::Helpers
  Warden.test_mode!
  Capybara::Screenshot.prune_strategy = { keep: 50 }
end
