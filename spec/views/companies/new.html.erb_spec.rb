require 'spec_helper'

describe "companies/new" do
  before(:each) do
    assign(:company, stub_model(Company,
      :name => "",
      :contact_id => FactoryGirl.create(:contact).id
    ).as_new_record)

  end

end
