require 'spec_helper'

describe "discussions/edit" do
  before(:each) do
    @discussion = assign(:discussion, stub_model(Discussion,
      :topic => "",
      :moderator => 1,
      :due_date => ""
    ))
  end

  it "renders the edit discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discussion_path(@discussion), "post" do
      assert_select "input#discussion_topic[name=?]", "discussion[topic]"
      assert_select "input#discussion_moderator[name=?]", "discussion[moderator]"
      assert_select "input#discussion_due_date[name=?]", "discussion[due_date]"
    end
  end
end
