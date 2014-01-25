require 'spec_helper'

describe "votes/new" do
  before(:each) do
    assign(:vote, stub_model(Vote,
      :argument_id => 1,
      :user_id => 1,
      :is_like => false
    ).as_new_record)
  end

  it "renders new vote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", votes_path, "post" do
      assert_select "input#vote_argument_id[name=?]", "vote[argument_id]"
      assert_select "input#vote_user_id[name=?]", "vote[user_id]"
      assert_select "input#vote_is_like[name=?]", "vote[is_like]"
    end
  end
end
