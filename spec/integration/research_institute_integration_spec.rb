require 'spec_helper'
require 'integration/integration_helpers'

describe 'research institute' do
  def register_research_institute
    visit '/research_institutes/new'
    within '#new_research_institute' do
      fill_in 'research_institute_name', with: "test RI"
      fill_in 'research_institute_contact_attributes_street', with: 'Test Street 4'
      fill_in 'research_institute_contact_attributes_postalcode', with: '12344'
      fill_in 'research_institute_contact_attributes_town', with: 'Berlin'
      fill_in 'research_institute_contact_attributes_telephone', with: '021142158'
      fill_in 'research_institute_deputy_attributes_username', with: 'test_username'
      fill_in 'research_institute_deputy_attributes_firstname', with: 'test_firstname'
      fill_in 'research_institute_deputy_attributes_lastname', with: 'test_lastname'
      fill_in 'research_institute_deputy_attributes_email', with: 'test@test.test'
      fill_in 'research_institute_deputy_attributes_password', with: '123456789'
      fill_in 'research_institute_deputy_attributes_password_confirmation', with: '123456789'
      click_on 'Anmelden'
    end
  end

  describe 'register research instute' do
    it 'creates a new research institute' do
      expect{
        register_research_institute
      }.to change(ResearchInstitute, :count).by(1)
    end

    it "redirects to the users page after sign up" do
      pending 'confirmation page instead'
      register_research_institute
      expect( current_path ).to eq user_path(User.last)
    end
  end

  context '[signed in]' do
    let!(:ri){ create(:research_institute) }
    let!(:user){ ri.deputy.research_institutes << ri; ri.deputy } # FIXME nicer

    before do
      login_as(user, scope: :user)
    end

    describe 'research institutes page' do
      it "has a Profile link" do
        visit root_path
        click_link 'Profil'
        expect( current_path ).to eq "/profile"
      end

      it "redirects to the new discussion page when link is clicked" do
        create(:company)
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
    end
  end
end
