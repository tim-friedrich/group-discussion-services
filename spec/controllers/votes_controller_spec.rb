require 'spec_helper'


RSpec.describe VotesController, :type => :controller do
  let(:user){ create(:user_with_survey) }
  let(:discussion){ create(:discussion) }
  let(:question) { create(:question) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:vote,
      argument_id: create(:argument,
        question: Question.create(topic: "ASDasd",
          discussion: discussion),
          discussion: discussion).id,
      user_id: create(:user).id
    )
  }
  let(:valid_session) { {} }

  before(:each) do
    sign_in user
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vote" do
        expect {
          post :create, {:vote => valid_attributes}, valid_session
        }.to change(Vote, :count).by(1)
      end

      it "assigns a newly created vote as @vote" do
        post :create, {:vote => valid_attributes}, valid_session
        assigns(:vote).should be_a(Vote)
        assigns(:vote).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vote as @vote" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vote.any_instance.stub(:save).and_return(false)
        post :create, {:vote => { "argument_id" => "invalid value" }}, valid_session
        assigns(:vote).should be_a_new(Vote)
      end
    end
  end

end
