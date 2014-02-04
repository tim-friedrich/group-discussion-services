require 'spec_helper'

describe "research_institutes/new" do
  before(:each) do
    assign(:research_institute, stub_model(ResearchInstitute,
      :name => "",
      :contact_id => ""
    ).as_new_record)
  end

  it "renders new research_institute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", research_institutes_path, "post" do
      assert_select "input#research_institute_name[name=?]", "research_institute[name]"
      assert_select "input#research_institute_contact_id[name=?]", "research_institute[contact_id]"
    end
  end
end
