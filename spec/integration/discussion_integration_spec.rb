require 'spec_helper'
require 'integration/integration_helpers'

describe 'discussion', js: true do
  let(:discussion){ create(:discussion) }
  use_before_unload_hack

  before do
    @confirmed_users = discussion.discussions_users.all.select{ | obj | (obj.confirmed && obj.role.name == "proband") }
    @unconfirmed_user = create(:user_with_survey)
    discussion.users << @unconfirmed_user
    @unconfirmed_user_discussion = discussion.discussions_users.where(user_id: @unconfirmed_user.id).first

    @observer = create(:user_with_survey)
    discussion.users << @observer
    observer_discussion = discussion.discussions_users.where(user_id: @observer.id).first
    observer_discussion.role = Role.where(name: 'observer').first
    observer_discussion.confirmed = true
    observer_discussion.save
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

      it "should be possible to enter the discussion" do
        visit discussion_path(discussion)
        expect( current_path ).to eq discussion_path(discussion)
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
          expect( page.find('#users') ).to have_element '##{@unconfirmed_user.id}'
        end
        it "should be listed as online when one is in discussion" do
          page.find_by_id("#{ @user.id }").find("img")['src'].should eq "/assets/online.jpg"
        end
        it "should be listed as offline when one is in discussion" do
          page.find_by_id("#{ @confirmed_users[3].user.id }").find("img")['src'].should eq "/assets/offline.jpg"
        end
        it "should not list the unconfirmed user" do
          id = "#{@unconfirmed_user.id}"
          page.should have_no_selector(id)
          #expect( page.find('#users') ).not_to have_selector('#'+@unconfirmed_user.id.to_s)
        end
      end

      it "should not have a visual aids tab" do
        expect( page ).not_to have_link("Medien")
      end

      it "should not possible to see observer arguments" do
        argument = create(:observer_argument, discussion: discussion)
        visit discussion_path(discussion)
        expect( page.find("#discussion_chat") ).not_to have_content(argument.content)
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

    # TODO emoticon tests
  end

  describe "as Moderator" do
    before do
      login_as discussion.moderator
      visit discussion_path(discussion)
    end

    it "should post a new question" do
      page.execute_script("
            $('#argument_content').text('important question')
          ")
      page.find('.dropdown-toggle').click
      element = page.find('#new_question_button', :visible=>false)
      element.click
      expect( page.find_by_id('question') ).to have_content 'important question'
    end

    it "should have a visual aids tab" do
      expect( page ).to have_link("Medien")
    end
    it "should be possible to see observer arguments" do
      argument = create(:observer_argument, discussion: discussion, user: @observer )
      visit discussion_path(discussion)
      expect( page.find("#discussion_chat") ).to have_content(argument.content)
    end

    # TODO Visual aid tests
  end

  describe "as Observer" do
    before do

      login_as @observer
      visit discussion_path(discussion)
    end
    describe "new argument" do
      it "should be visible" do
        send_argument
        expect( page.find("#discussion_chat") ).to have_content('test')
      end
    end
  end
end