require 'spec_helper'
require 'integration/integration_helpers'

describe 'User' do
  def user_sign_up
    visit '/users/sign_up'
    within '#new_user' do
      fill_in 'user_username', with: 'test_username'
      fill_in 'user_firstname', with: 'test_firstname'
      fill_in 'user_lastname', with: 'test_lastname'
      fill_in 'user_email', with: 'test@test.test'
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
    let!(:user){ create(:user) }

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

    describe "user is moderator" do
      before do
        user.role = Role.find_by_name('moderator')
        user.save
      end

      it "redirects to the new discussion page when link is clicked" do
        visit root_path
        click_link 'Profil'
        click_link 'neue Diskussion erstellen'
        expect( current_path ).to eq new_discussion_path
      end

      it "redirects to the new company page when link was clicked" do
        visit root_path
        click_link 'Profil'
        click_link 'neuen Kunden anlegen'
        expect( current_path ).to eq new_company_path
      end

      it "redirects to the edit discussion page when link was clicked" do
        visit root_path

      end
    end
  end
end
