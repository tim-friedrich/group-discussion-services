require 'spec_helper'

describe "discussions/index" do
  before(:each) do
     @user = FactoryGirl.create(:user)
    
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
  
  let(:user) { FactoryGirl.create(:user)}
  let(:discussions) { [FactoryGirl.create(:discussion, moderator: :user), FactoryGirl.create(:discussion, moderator: FactoryGirl.create(:user))]}
  
  it "renders a list of discussions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => @user.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
