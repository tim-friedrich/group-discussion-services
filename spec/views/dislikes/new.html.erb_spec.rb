require 'spec_helper'

describe "dislikes/new" do
  before(:each) do
    assign(:dislike, stub_model(Dislike,
      :argument_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new dislike form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dislikes_path, "post" do
      assert_select "input#dislike_argument_id[name=?]", "dislike[argument_id]"
      assert_select "input#dislike_user_id[name=?]", "dislike[user_id]"
    end
  end
end
