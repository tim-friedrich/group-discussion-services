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

def accept_js_confirm(page)
  if page.driver.class == Capybara::Selenium::Driver
    page.driver.browser.switch_to.alert.accept
  elsif page.driver.class == Capybara::Webkit::Driver
    page.driver.browser.accept_js_confirms
  end
end