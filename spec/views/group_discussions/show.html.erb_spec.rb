require 'spec_helper'

describe "group_discussions/show" do
  before(:each) do
    @group_discussion = assign(:group_discussion, stub_model(GroupDiscussion))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
