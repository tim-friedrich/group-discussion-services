require 'spec_helper'

describe "discussions/new" do
  before(:each) do
     @user = FactoryGirl.create(:user)
     sign_in(@user)
     assign(:discussion, FactoryGirl.stub(Discussion,
      :topic => "Test",
      :moderator => @user,
      :due_date => DateTime.now,
      :company =>  FactoryGirl.create(:company)
    ).as_new_record)
  end

  it "renders new discussion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discussions_path, "post" do
      assert_select "input#discussion_topic[name=?]", "discussion[topic]"
      assert_select "select#discussion_moderator_id[name=?]", "discussion[moderator_id]"
      assert_select "input#discussion_due_date[name=?]", "discussion[due_date]"
      assert_select "select#discussion_company[name=?]", "discussion[company]"
    end
  end
end
