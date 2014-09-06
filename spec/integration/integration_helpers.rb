
require 'spec_helper'

def sign_up
  visit '/users/sign_up'
  within '#new_user' do
    fill_in 'user_username', with: 'test_username'
    fill_in 'user_firstname', with: 'test_firstname'
    fill_in 'user_lastname', with: 'test_lastname'
    fill_in 'user_email', with: 'test@test.test'
    fill_in 'user_password', with: '123456789'
    fill_in 'user_password_confirmation', with: '123456789'
    click_on 'User erstellen'
  end
end

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

def create_company
  visit '/companies/new'
  within '#new_company' do
    fill_in 'company_name', with: 'example GmbH'
    fill_in 'company_contact_attributes_street', with: 'Test Street 4'
    fill_in 'company_contact_attributes_postalcode', with: '12344'
    fill_in 'company_contact_attributes_town', with: 'Berlin'
    fill_in 'company_contact_attributes_telephone', with: '021142158'
    click_on 'Company erstellen'
  end
end