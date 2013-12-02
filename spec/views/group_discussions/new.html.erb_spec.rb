require 'spec_helper'

describe "group_discussions/new" do
  before(:each) do
    assign(:group_discussion, stub_model(GroupDiscussion).as_new_record)
  end

  it "renders new group_discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", group_discussions_path, "post" do
    end
  end
end
