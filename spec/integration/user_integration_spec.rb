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
  end

  describe 'log in' do
    let!(:user){ create(:user) }

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
