require 'spec_helper'

describe ArgumentsController do
	before do
		@argument = FactoryGirl.create(:argument)
		@valid_attributes = FactoryGirl.attributes_for(:argument, question_id: FactoryGirl.create(:question).id, user_id: FactoryGirl.create(:user).id)
	end

	let(:valid_session) { }

	describe "GET show" do
    	it "assigns the argument" do
      	argument = Argument.create! @valid_attributes
      	get :show, {}, valid_session
      	assigns(:argument).should eq([argument])
    end


  end

end
