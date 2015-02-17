require 'spec_helper'
require 'integration/integration_helpers'

describe 'discussion', js: true do
  let(:discussion){ create(:discussion) }
  use_before_unload_hack

  before do
    @confirmed_users = discussion.discussions_users.select{ | obj | obj.confirmed == true }
    @unconfirmed_user = create(:user_with_survey)
    discussion.users << @unconfirmed_user
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
        @user = @confirmed_users.first.user
        login_as @user
        visit discussion_path(discussion)
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
      describe "user status" do

        it "should list the confirmed user" do
          expect( page.find('#users') ).to have_content @user.username
        end
        it "should be listed as online" do

        end
        it "should not list the unconfirmed user" do
          expect( page.find('#users') ).not_to have_content @user.username
        end
      end
    end
    describe "that is not confirmed" do
      before do
        login_as @unconfirmed_user
      end
      it "should not possible to enter the discussion" do
        visit discussion_path(discussion)
        expect( current_path ).not_to eq discussion_path(discussion)
      end
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