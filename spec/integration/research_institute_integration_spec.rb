require 'spec_helper'


describe 'research institute' do
  def register_research_institute
    visit '/research_institutes/new'
    within '#new_research_institute' do
      fill_in 'research_institute_name', with: "test RI"
      fill_in 'research_institute_contact_attributes_street', with: 'Test Street 4'
      fill_in 'research_institute_contact_attributes_postalcode', with: '12344'
      fill_in 'research_institute_contact_attributes_town', with: 'Berlin'
      fill_in 'research_institute_contact_attributes_telephone', with: '021142158'
      fill_in 'research_institute_deputy_attributes_firstname', with: 'test_firstname'
      fill_in 'research_institute_deputy_attributes_lastname', with: 'test_lastname'
      fill_in 'research_institute_deputy_attributes_email', with: 'test@test.test'
      fill_in 'research_institute_deputy_attributes_birthday', with: '05.05.1980'
      fill_in 'research_institute_deputy_attributes_zipcode', with: '12345'
      select 'Grönland', from: 'research_institute_deputy_attributes_country'
      fill_in 'research_institute_deputy_attributes_city', with: 'Kreuzberg'
      select 'männlich', from: 'research_institute_deputy_attributes_gender'
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
      register_research_institute
      expect( current_path ).to eq profile_path
    end
  end
end
