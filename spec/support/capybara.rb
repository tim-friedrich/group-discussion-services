RSpec.configure do |config|
  require 'capybara/rails'
  require 'capybara/poltergeist'
  require 'capybara-screenshot/rspec'
  Capybara.javascript_driver = ENV.has_key?("DRIVER") ? ENV["DRIVER"].to_sym : :webkit
  # other options: selenium, poltergeist

  config.include Capybara::DSL
  Capybara.default_wait_time = 5

  #config.include Devise::TestHelpers, type: :feature
  config.include Warden::Test::Helpers
  Warden.test_mode!
  Capybara::Screenshot.prune_strategy = { keep: 50 }
end
