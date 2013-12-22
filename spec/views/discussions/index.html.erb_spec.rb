require 'spec_helper'

describe "discussions/index" do
  before(:each) do
     @user = User.new(firstName: "karl", surname: "Peterson", email: "karl@example.com", role: Role.where(name:"user").first, password: "foobar", password_confirmation: "foobar")
    
    assign(:discussions, [
      stub_model(Discussion,
        :topic => "",
        :moderator => @user,
        :due_date => ""
      ),
      stub_model(Discussion,
        :topic => "",
        :moderator => @user,
        :due_date => ""
      )
    ])
  end

  it "renders a list of discussions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => @user.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
