require 'spec_helper'

describe "discussions/edit" do
  let(:user) { FactoryGirl.create(:user)}
  let(:discussion) { FactoryGirl.create(:discussion, moderator: :user)}
  
  it "renders the edit discussion form" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discussion_path(@discussion), "post" do
      assert_select "input#discussion_topic[name=?]", "discussion[topic]"
      assert_select "select#discussion_moderator_id[name=?]", "discussion[moderator_id]"
      assert_select "input#discussion_due_date[name=?]", "discussion[due_date]"
    end
  end
end
