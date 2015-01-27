require 'spec_helper'

# TODO move to company integration spec

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