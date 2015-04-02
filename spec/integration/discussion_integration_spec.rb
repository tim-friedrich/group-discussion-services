require 'spec_helper'


describe 'Discussion', js: true do
  let(:discussion){ F.create(:discussion) }
  use_before_unload_hack

  before do
    @confirmed_users = discussion.discussions_users.all.select{ | obj | (obj.confirmed && obj.role.name == "proband") }
    @unconfirmed_user = F.create(:user_with_survey)
    discussion.users << @unconfirmed_user
    @unconfirmed_user_discussion = discussion.discussions_users.where(user_id: @unconfirmed_user.id).first

    @observer = F.create(:user_with_survey)
    discussion.users << @observer
    observer_discussion = discussion.discussions_users.where(user_id: @observer.id).first
    observer_discussion.role = Role.observer
    observer_discussion.confirmed = true
    observer_discussion.save
  end
  def send_argument
    page.execute_script("
            $('#new_argument_content').text('test')
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
          expect( find('#arguments') ).to have_content "test"
        end

        it "should clear the argument form after submit" do
          send_argument
          page.execute_script("
              $('#argument_content').text('test')
            ")
          page.find('#new_argument_button').click
          expect( find('#new_argument_content') ).not_to have_content "test"
        end
      end

      describe "user status" do
        it "should list the confirmed user" do
          expect( find('#probands-list') ).to have_content @user.username_in(discussion)
        end

        it "should be listed as online when one is in discussion" do
          page.find_by_id(@user.id).should_not have_css(".offline")
          expect( page.find_by_id(@user.id)[:class].include?("offline")).to eq false
        end

        it "should be listed as offline when one is in discussion" do
          expect( page.find_by_id(@confirmed_users[3].user.id)[:class].include?("offline")).to eq true
          #page.find_by_id(@confirmed_users[3].user.id).should have_css(".offline")
        end

        it "should not list the unconfirmed user" do
          expect( find('#probands-list') ).not_to have_content @unconfirmed_user.username_in(discussion)
        end
      end

      it "should not have a visual aids tab" do
        expect( page ).not_to have_link("Medien")
      end

      it "should not possible to see observer arguments" do
        argument = F.create(:observer_argument, discussion: discussion)
        visit discussion_path(discussion)
        expect( page.find("#arguments") ).not_to have_content(argument.content)
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
            $('#new_argument_content').text('important question')
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
      argument = F.create(:observer_argument, discussion: discussion, user: @observer )
      visit discussion_path(discussion)
      expect( page.find("#arguments") ).to have_content(argument.content)
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
        expect( page.find("#arguments") ).to have_content('test')
      end
    end
  end
=begin
  describe "discussion edit" do

    before do
      @research_institute = create(:research_institute)
      @research_institute.deputy = discussion.moderator
      discussion.moderator.research_institutes << @research_institute
      @research_institute.save()
      login_as discussion.moderator
      @user = FactoryGirl.attributes_for(:user)
    end

    def invite_proband
      visit edit_discussion_path(discussion)
      click_link 'Teilnehmer'
      click_link 'Probanden Einladen'
      page.execute_script("
            $('#user_email').val('#{ @user[:email] }');
            $('#new_proband').submit();
          ")
      click_link('Einladung senden')
    end

    describe "user invitations" do
      it "should create a new discussions_user" do
        expect { invite_proband() }.to change(DiscussionsUser, :count).by(1)
      end
      it "should create a new user" do
        expect { invite_proband() }.to change(User, :count).by(1)
      end
      it "should have the research_institute under the new users research_institutes" do
        invite_proband
        expect( User.where(email: @user[:email]).first.research_institutes.count ).to eq 1
      end

      it "have the DiscussionsUser name Unbekannt for new users" do
        invite_proband
        user2 = User.where(email: @user[:email]).first
        discussions_user = discussion.discussions_users.where(user_id: user2.id).first
        expect ( discussions_user.name ).to eq "Unbekannt"
      end

      it "should change the DiscussionsUser name after registration" do
        invite_proband
        click_link "Abmelden"
        user2 = User.where(email: @user[:email]).first
        visit accept_user_invitation_url(:invitation_token => user2.raw_invitation_token)
        within '#edit_user' do
          fill_in 'user_firstname', with: 'test_firstname'
          fill_in 'user_lastname', with: 'test_lastname'
          select 'weiblich', :from => 'user_gender'
          fill_in 'user_birthday', with: '31.12.1990'
          fill_in 'user_password', with: '123456789'
          fill_in 'user_zipcode', with: '12345'
          fill_in 'user_password_confirmation', with: '123456789'
          click_on 'Weiter'
        end
        discussions_user = discussion.discussions_users.where(user_id: user2.id).first
        expect( discussion_user.name ).not_to eq "Unbekannt"
      end
    end
  end
=end
end
