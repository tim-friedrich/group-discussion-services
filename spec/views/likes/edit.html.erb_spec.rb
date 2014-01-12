require 'spec_helper'

describe "likes/edit" do
  before(:each) do
    @like = assign(:like, stub_model(Like,
      :integer => "",
      :integer => ""
    ))
  end

  it "renders the edit like form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", like_path(@like), "post" do
      assert_select "input#like_integer[name=?]", "like[integer]"
      assert_select "input#like_integer[name=?]", "like[integer]"
    end
  end
end
