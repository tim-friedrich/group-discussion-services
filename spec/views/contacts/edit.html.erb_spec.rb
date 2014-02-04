require 'spec_helper'

describe "contacts/edit" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :street => "",
      :postalcode => "",
      :town => "",
      :email => "",
      :telephone => ""
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do
      assert_select "input#contact_street[name=?]", "contact[street]"
      assert_select "input#contact_postalcode[name=?]", "contact[postalcode]"
      assert_select "input#contact_town[name=?]", "contact[town]"
      assert_select "input#contact_email[name=?]", "contact[email]"
      assert_select "input#contact_telephone[name=?]", "contact[telephone]"
    end
  end
end
