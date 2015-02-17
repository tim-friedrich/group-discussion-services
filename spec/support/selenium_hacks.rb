
# after each test navigate away before Capybara tries to so that
# we can appropriately handle the onbeforeunload dialog
def use_before_unload_hack
  after do
    if page.driver.class == Capybara::Selenium::Driver
      begin
        page.driver.browser.navigate.to("about:blank")
        page.driver.browser.switch_to.alert.accept
      rescue Selenium::WebDriver::Error::NoAlertPresentError
      end
    end
  end
end