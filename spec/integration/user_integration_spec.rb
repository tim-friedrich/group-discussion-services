require 'rspec'
require 'spec_helper'
require 'integration/integration_helpers'

#class UserIntegrationTest < ActionDispatch::IntegrationTest
#  test "user" do
#    sign_up
#    visit root_url
#    click_link 'Profil'#

#  end
#end
describe 'users' do

  describe 'users signed in' do
    before do
      sign_up
    end

    describe 'users page' do
      it 'should be reacheable from the index page' do
         visit root_url
         click_link 'Profil'
      end
      it "should not have the profile link after sign out" do
        click_link "Abmelden"
        should_not have_link "Profile"
      end
      it "should redirect to the users page after sign_up" do
        current_path.should eq root_path
      end
    end
  end
end
