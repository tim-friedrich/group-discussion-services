require 'spec_helper'
require 'integration/integration_helpers'

describe 'discussion', js: true do
  let(:user){ create(:user_with_survey) }

  before do
    @discussion = create(:discussion)
    login_as @discussion.moderator

    visit "/discussions/#{@discussion.id}"
  end
  describe "new argument" do
    before do

    end
    it "should post a new argument" do
      find('#argument_content').set "test"
      page.find('#new_argument_button').click
      expect( page ).to have_content "test"
    end

    it "should clear the argument form after submit" do
      find('#argument_content').set "test"
      page.find('#new_argument_button').click
      expect( find('#argument_content') ).not_to have_content "test"
    end

    #moderators
    it "should post a new question" do

    end
  end
end