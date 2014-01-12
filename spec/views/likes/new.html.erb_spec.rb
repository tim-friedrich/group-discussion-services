require 'spec_helper'

describe "likes/new" do
  before(:each) do
    assign(:like, stub_model(Like,
      :integer => "",
      :integer => ""
    ).as_new_record)
  end

  it "renders new like form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", likes_path, "post" do
      assert_select "input#like_integer[name=?]", "like[integer]"
      assert_select "input#like_integer[name=?]", "like[integer]"
    end
  end
end
