require 'spec_helper'

describe "contacts/new" do
  before(:each) do
    assign(:contact, stub_model(Contact,
      :street => "",
      :postalcode => "",
      :town => "",
      :email => "",
      :telephone => ""
    ).as_new_record)
  end

  it "renders new contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contacts_path, "post" do
      assert_select "input#contact_street[name=?]", "contact[street]"
      assert_select "input#contact_postalcode[name=?]", "contact[postalcode]"
      assert_select "input#contact_town[name=?]", "contact[town]"
      assert_select "input#contact_email[name=?]", "contact[email]"
      assert_select "input#contact_telephone[name=?]", "contact[telephone]"
    end
  end
end
