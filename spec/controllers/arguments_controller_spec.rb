require 'spec_helper'

describe ArgumentsController do
	let(:discussion) { FactoryGirl.create(:discussion) }
	let(:question) { FactoryGirl.create(:question, discussion: discussion) }
	let(:argument) { FactoryGirl.build(:argument, question: question) }

	let(:valid_attributes) { FactoryGirl.attributes_for(:argument, question: question) }
	let(:valid_session) {}

	describe "signed in" do
		before do
	    	@user = FactoryGirl.create(:user)
	    	sign_in @user
	    end

	    describe "create" do
	    	it "with valid parameters should create a new argument" do

	          expect {
	            post :create, {argument: valid_attributes}, valid_session
	          }.to change(Argument, :count).by(1)
		    end

		    it "with invalid parameters should not create a new argument" do
          expect {
            post :create, {:argument => valid_attributes}, valid_session
          }.to change(Argument, :count).by(0)
		    end
	    end
	end
end
