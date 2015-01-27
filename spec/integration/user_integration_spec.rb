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
      click_on 'Benutzer erstellen'
    end
  end

  describe 'sign up' do
    it "creates a new user" do
      expect{
        user_sign_up
      }.to change(User, :count).by(1)
    end

    it "should redirect to the users page after sign_up" do
      user_sign_up
      current_path.should eq user_path(User.last)
    end
  end

  describe 'log in' do
    let!(:user){ create(:user) }

    it 'shows the profile link' do
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: '123456789'
      click_on "Sign in"
      expect( page ).to have_link "Profil"
    end
  end

  context '[signed in]' do
    let!(:user){ create(:user) }

    before do
      login_as(user, scope: :user)
    end

    it "should not have the profile link after sign out" do
      visit root_path
      click_link "Abmelden"
      expect( page ).not_to have_link "Profil"
    end
  end
end
