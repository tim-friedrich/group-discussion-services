require 'rspec'
require 'spec_helper'
require 'integration/integration_helpers'

describe 'research_institute' do

  describe 'signed in' do
    before do
      register_research_institute
    end

    describe 'research_institutes page' do
      it "should redirect to the users page after sign_up" do
        current_path.should eq user_path User.last
      end
      it "should has a Profile link" do
        visit root_url
        click_link 'Profil'
        current_path.should eq user_path User.last
      end
      it "should redirect to the new discussion page when link is clicked" do
        #needed to create company
        create_company
        click_link 'neue Diskussion erstellen'
        current_path.should eq new_discussion_path
      end
      it "should redirect to the new company page when link was clicked" do
        click_link 'neuen Kunden anlegen'
        current_path.should eq new_company_path
      end
    end
  end
end
