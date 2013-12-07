require 'spec_helper'

describe "discussions/new" do
  before(:each) do
    assign(:discussion, stub_model(Discussion,
      :topic => "",
      :moderator => 1,
      :due_date => ""
    ).as_new_record)
  end

  it "renders new discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discussions_path, "post" do
      assert_select "input#discussion_topic[name=?]", "discussion[topic]"
      assert_select "input#discussion_moderator[name=?]", "discussion[moderator]"
      assert_select "input#discussion_due_date[name=?]", "discussion[due_date]"
    end
  end
end
