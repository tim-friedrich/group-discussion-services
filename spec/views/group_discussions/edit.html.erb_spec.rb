require 'spec_helper'

describe "group_discussions/edit" do
  before(:each) do
    @group_discussion = assign(:group_discussion, stub_model(GroupDiscussion))
  end

  it "renders the edit group_discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", group_discussion_path(@group_discussion), "post" do
    end
  end
end
