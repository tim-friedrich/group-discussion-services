require 'spec_helper'


RSpec.describe VotesController, :type => :controller do
  before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @discussion = FactoryGirl.create(:discussion)
  end

  let(:question) { FactoryGirl.create(:question) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:vote,
                                argument_id: FactoryGirl.create(:argument,
                                          question: Question.create(topic: "ASDasd",
                                              discussion: @discussion),
                                              discussion: @discussion).id,
                                user_id: FactoryGirl.create(:user).id )}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VotesController. Be sure to keep this updated too.
  let(:valid_session) { {} }


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
