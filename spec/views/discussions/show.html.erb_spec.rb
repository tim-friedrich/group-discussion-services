require 'spec_helper'

describe "discussions/show" do
  before(:each) do
    @discussion = assign(:discussion, stub_model(Discussion,
      :topic => "",
      :moderator => 1,
      :due_date => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
