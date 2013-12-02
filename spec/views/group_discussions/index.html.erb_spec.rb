require 'spec_helper'

describe "group_discussions/index" do
  before(:each) do
    assign(:group_discussions, [
      stub_model(GroupDiscussion),
      stub_model(GroupDiscussion)
    ])
  end

  it "renders a list of group_discussions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
