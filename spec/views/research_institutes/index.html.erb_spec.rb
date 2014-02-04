require 'spec_helper'

describe "research_institutes/index" do
  before(:each) do
    assign(:research_institutes, [
      stub_model(ResearchInstitute,
        :name => "",
        :kontakt_id => ""
      ),
      stub_model(ResearchInstitute,
        :name => "",
        :kontakt_id => ""
      )
    ])
  end

  it "renders a list of research_institutes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
