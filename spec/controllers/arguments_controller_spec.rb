require 'spec_helper'

describe ArgumentsController do
	before do
	  	@user = FactoryGirl.create(:user)
	   	sign_in @user
	   	@discussion = FactoryGirl.create(:discussion)
	end
	
	let(:question) { FactoryGirl.create(:question, discussion_id: @discussion.id) }
	let(:argument) { FactoryGirl.build(:argument, question: question) }

	let(:valid_attributes) { FactoryGirl.attributes_for(:argument, question: question, user_id: @user.id, discussion_id: @discussion.id) }
	let(:valid_session) {}

	describe "signed in" do
	end
end
