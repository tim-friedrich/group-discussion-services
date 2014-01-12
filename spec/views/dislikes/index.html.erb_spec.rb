require 'spec_helper'

describe "dislikes/index" do
  before(:each) do
    assign(:dislikes, [
      stub_model(Dislike,
        :argument_id => 1,
        :user_id => 2
      ),
      stub_model(Dislike,
        :argument_id => 1,
        :user_id => 2
      )
    ])
  end

  it "renders a list of dislikes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
