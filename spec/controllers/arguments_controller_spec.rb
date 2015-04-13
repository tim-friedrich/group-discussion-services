require 'spec_helper'


RSpec.describe ArgumentsController, :type => :controller do
  render_views


  before do
    @argument = F.create(:argument)
    @discussion = F.create(:discussion)
    @user = @discussion.users.last
    @valid_attributes = { content: "test", discussion_id: @discussion.id, type: "proband" }
    sign_in @user
  end
  let(:valid_session) { }


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Argument" do
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
