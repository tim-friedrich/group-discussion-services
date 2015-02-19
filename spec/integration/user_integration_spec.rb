require 'spec_helper'
require 'integration/integration_helpers'

describe 'User' do
  def user_sign_up
    visit '/users/sign_up'
    within '#new_user' do
      fill_in 'user_firstname', with: 'test_firstname'
      fill_in 'user_lastname', with: 'test_lastname'
      fill_in 'user_email', with: 'test@test.test'
      fill_in 'user_gender', with: 'female'
      fill_in 'user_birthday', with: '1990-12-31'
      fill_in 'user_password', with: '123456789'
      fill_in 'user_password_confirmation', with: '123456789'
      click_on 'Weiter'
    end
  end

  describe 'sign up' do
    it "creates a new user" do
      expect{
        user_sign_up
      }.to change(User, :count).by(1)
    end

    it "should redirect to survey after sign_up" do
      user_sign_up
      current_path.should eq '/survey'
    end
  end

  describe 'log in' do
    let!(:user){ create(:user_with_survey) }

    it 'shows the profile link' do
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: '123456789'
      click_button "Anmelden"
      expect( page ).to have_link "Profil"
    end
  end

  context '[signed in]' do
    let!(:user){ create(:user_with_survey) }

    before do
      login_as(user, scope: :user)
    end

    it '/ redirects to profile page' do
      visit root_path
      expect( current_path ).to eq "/profile"
    end

    describe "user is proband" do
      describe "profile page" do
        it "should not have new discussion link" do
          expect( page ).not_to have_link "neue Diskussion erstellen"
        end
        it "should not have new company link" do
          expect( page ).not_to have_link "neuen Kunden anlegen"
        end
        describe "new Discussion" do
          before do
            @discussion = create(:discussion)
            @discussion.users << user
            visit "/profile"
          end
          it "should have confirm discussion link" do
            expect( page ).to have_link("Zusagen")
          end

          it "should have join discussion link after accept discussion" do
            click_link "Zusage"
            expect( page ).to have_link( "Diskussion beitreten" )
          end

          it "should redirect to the discussion if link is clicked" do
            click_link "Zusagen"
            click_link "Diskussion beitreten"
            expect( current_path ).to eq discussion_path(@discussion)
          end
        end
      end
    end

    describe "user is moderator" do
      before do
        @moderator = create(:moderator)
        login_as(@moderator, scope: :user)
      end
      describe "profile page" do
        before do
          visit "/profile"
        end
        it "redirects to the new discussion page when link is clicked" do
          click_link 'neue Diskussion erstellen'
          expect( current_path ).to eq new_discussion_path
        end

        it "redirects to the new company page when link was clicked" do
          click_link 'neuen Kunden anlegen'
          expect( current_path ).to eq new_company_path
        end
        describe "Discussion" do
          before do
            @discussion = create(:discussion, moderator: @moderator)
            visit "/profile"
          end
          it "redirects to the edit discussion page when link was clicked" do
            click_link "Bearbeiten"
            expect( current_path ).to eq edit_discussion_path(@discussion)
          end
          it "should be possible to delete a discussion" do
            expect{
              click_link "Löschen"
            }.to change(Discussion, :count).by(-1)
          end

          it "should not nessary to accept a discussion" do
            expect( page ).to_not have_link("Zusagen")
          end
        end

        describe "Company" do
          before do
            @research_institute = create(:research_institute, deputy: @moderator)
            @company = create(:company, research_institute: @research_institute)
            @moderator.research_institutes << @research_institute
            @moderator.save
            visit "/profile"
          end
          it "redirects to the edit company page when link was clicked" do
            click_link "Bearbeiten"
            expect( current_path ).to eq edit_company_path(@company)
          end
          it "should be possible to delete a company" do
            expect{
              click_link "Löschen"
            }.to change(Company, :count).by(-1)
          end
        end
      end
    end
  end
end
