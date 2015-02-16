require 'spec_helper'


RSpec.describe ArgumentsController, :type => :controller do
  before do
    @argument = FactoryGirl.create(:argument)
    @discussion = FactoryGirl.create(:discussion)
    @valid_attributes = FactoryGirl.attributes_for(:argument)
    @valid_attributes[:type] = 'proband'
    @valid_attributes[:discussion_id] = @discussion.id
    @user = FactoryGirl.create(:user)
    @discussion.questions << FactoryGirl.create(:question)
    @discussion.users << @user
    sign_in @user
  end
  let(:valid_session) { }

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Argument" do
        puts @valid_attributes
        expect {
          post :create, {:argument => @valid_attributes}, valid_session
        }.to change(Argument, :count).by(1)
      end

      it "assigns a newly created argument as @argument" do
        post :create, {:argument => @valid_attributes}, valid_session
        assigns(:argument).should be_a(Argument)
        assigns(:argument).should be_persisted
      end
    end
  end
end
