require 'spec_helper'

describe "research_institutes/edit" do
  before(:each) do
    @research_institute = assign(:research_institute, stub_model(ResearchInstitute,
      :name => "",
      :kontakt_id => ""
    ))
  end

  it "renders the edit research_institute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", research_institute_path(@research_institute), "post" do
      assert_select "input#research_institute_name[name=?]", "research_institute[name]"
      assert_select "input#research_institute_kontakt_id[name=?]", "research_institute[kontakt_id]"
    end
  end
end
