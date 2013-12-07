require 'spec_helper'

describe "discussions/index" do
  before(:each) do
    assign(:discussions, [
      stub_model(Discussion,
        :topic => "",
        :moderator => 1,
        :due_date => ""
      ),
      stub_model(Discussion,
        :topic => "",
        :moderator => 1,
        :due_date => ""
      )
    ])
  end

  it "renders a list of discussions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
