require 'spec_helper'

describe "research_institutes/show" do
  before(:each) do
    @research_institute = assign(:research_institute, stub_model(ResearchInstitute,
      :name => "",
      :contact_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
