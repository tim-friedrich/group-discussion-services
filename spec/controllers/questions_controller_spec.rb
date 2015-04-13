require 'spec_helper'


RSpec.describe QuestionsController, :type => :controller do
  before do
    @discussion = F.create(:discussion)
    @user =F. create(:moderator)
    sign_in @user
  end

  describe "POST create" do
    let(:valid_attributes) { F.attributes_for(:question, user_id: @user.id, discussion_id: @discussion.id) }
    let(:valid_session) { {} }

    describe "with valid params" do
      it "creates a new Question" do
        expect {
          post :create, {:question => valid_attributes}}.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, {:question => valid_attributes}, valid_session
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end
    end
  end
end

