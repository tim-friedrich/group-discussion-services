require 'spec_helper'

describe "discussions/new" do
  before(:each) do
     @user = User.new(firstName: "karl", surname: "Peterson", email: "karl@example.com", role: Role.where(name:"user").first, password: "foobar", password_confirmation: "foobar")
    
    assign(:discussion, stub_model(Discussion,
      :topic => "",
      :moderator => @user,
      :due_date => ""
    ).as_new_record)
  end

  it "renders new discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discussions_path, "post" do
      assert_select "input#discussion_topic[name=?]", "discussion[topic]"
      assert_select "select#discussion_moderator_id[name=?]", "discussion[moderator_id]"
      assert_select "input#discussion_due_date[name=?]", "discussion[due_date]"
    end
  end
end
