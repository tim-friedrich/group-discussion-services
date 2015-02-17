require 'spec_helper'
require 'integration/integration_helpers'

describe 'discussion', js: true do
  let(:user){ create(:user_with_survey) }
  let(:discussion){ create(:discussion) }
  after do
    # after each test navigate away before Capybara tries to so that we can appropriately handle the onbeforeunload dialog
    if page.driver.browser
      begin
        page.driver.browser.navigate.to("about:blank")
        page.driver.browser.switch_to.alert.accept
      rescue Selenium::WebDriver::Error::NoAlertPresentError
        # No alert was present. Don't need to do anything
      end
    end
  end
  before do
    discussion.users << user
  end
  def send_argument
    page.execute_script("
            $('#argument_content').text('test')
          ")
    page.find('#new_argument_button').click
  end
  describe "as Proband" do
    describe "that is confirmed" do
      before do
        discussions_user = discussion.discussions_users.select{ | obj | obj.user.id == user.id }.first
        discussions_user.confirmed = true
        discussions_user.save
        login_as user
        visit "/discussions/#{ discussion.id }"
      end
      describe "post new argument" do
        it "should post a new argument" do
          send_argument
          expect( page ).to have_content "test"
        end

        it "should clear the argument form after submit" do
            send_argument
            page.execute_script("
              $('#argument_content').text('test')
            ")
            page.find('#new_argument_button').click
            expect( find('#argument_content') ).not_to have_content "test"
        end
      end
    end
    describe "that is not confirmed" do

    end
  end

  describe "as Moderator" do
    before do
      login_as discussion.moderator
      visit "/discussions/#{ discussion.id }"
    end

    it "should post a new question" do
    end
  end
end