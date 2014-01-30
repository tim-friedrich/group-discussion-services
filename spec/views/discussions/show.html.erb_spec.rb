require 'spec_helper'

describe "discussions/show" do
  	let(:user) { FactoryGirl.create(:user)}
  	let(:discussion) { FactoryGirl.create(:discussion, moderator: :user)}
	
	before(:each){
	}
	it "renders show discussion form" do
	    render
	end

end
