require 'spec_helper'

describe DiscussionsController do

  let(:valid_session) {  }
  let(:valid_attributes) { FactoryGirl.attributes_for(:discussion, 
                              current_question_id: FactoryGirl.create(:question).id,
                              moderator_id: FactoryGirl.create(:user).id,
                              company_id: FactoryGirl.create(:company).id)
                          }

  describe "signed in" do
    before do
      @research_institute = FactoryGirl.create(:research_institute, deputy: FactoryGirl.create(:user), contact: FactoryGirl.create(:contact))
      @user = @research_institute.deputy
      @company = FactoryGirl.create(:company, research_institute: @research_institute, contact: FactoryGirl.create(:contact))
      @user.research_institutes << @research_institute
      sign_in @user
    end
    
    describe "GET" do  
      describe "index" do
        it "assigns all discussions as @discussions" do
          discussions = Discussion.all
          get :index, valid_session
          assigns(:discussions).should eq(discussions)
        end
      end

      describe "show" do
        it "assigns the requested discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          get :show, {:id => discussion.to_param}, valid_session
          assigns(:discussion).should eq(discussion)
        end
      end

      describe "new" do
        it "assigns a new discussion as @discussion" do
          get :new, valid_attributes, valid_session
          assigns(:discussion).should be_a_new(Discussion)
        end
      end

      describe "edit" do
        it "assigns the requested discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          get :edit, {:id => discussion.to_param}, valid_session
          assigns(:discussion).should eq(discussion)
        end
      end
    end
   
    describe "POST create" do
      describe "with valid params" do
        it "creates a new Discussion" do
          expect {
            post :create, {:discussion => valid_attributes}, valid_session
          }.to change(Discussion, :count).by(1)
        end

        it "assigns a newly created discussion as @discussion" do
          post :create, {:discussion => valid_attributes}, valid_session
          assigns(:discussion).should be_a(Discussion)
          assigns(:discussion).should be_persisted
        end

        it "redirects to the users show page" do
          post :create, {:discussion => valid_attributes}, valid_session
          response.should redirect_to(@user)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved discussion as @discussion" do
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          post :create, {:discussion => { "topic" => "invalid value" }}, valid_session
          assigns(:discussion).should be_a_new(Discussion)
        end

        it "re-renders the new template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          post :create, {:discussion => { "topic" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested discussion" do
          discussion = Discussion.create! valid_attributes
          # Assuming there are no other discussions in the database, this
          # specifies that the Discussion created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Discussion.any_instance.should_receive(:update).with({ "topic" => "" })
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "" }}, valid_session
        end

        it "assigns the requested discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          put :update, {:id => discussion.to_param, :discussion => valid_attributes}, valid_session
          assigns(:discussion).should eq(discussion)
        end

        it "redirects to the discussion" do
          discussion = Discussion.create! valid_attributes
          put :update, {:id => discussion.to_param, :discussion => valid_attributes}, valid_session
          response.should redirect_to(@user)
        end
      end

      describe "with invalid params" do
        it "assigns the discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "invalid value" }}, valid_session
          assigns(:discussion).should eq(discussion)
        end

        it "re-renders the edit template" do
          discussion = Discussion.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested discussion" do
        discussion = Discussion.create! valid_attributes
        expect {
          delete :destroy, {:id => discussion.to_param}, valid_session
        }.to change(Discussion, :count).by(-1)
      end

      it "redirects to the discussions list" do
        discussion = Discussion.create! valid_attributes
        delete :destroy, {:id => discussion.to_param}, valid_session
        response.should redirect_to(discussions_url)
      end
    end
  end

  describe "not signed in" do
    before do
      @research_institute = FactoryGirl.create(:research_institute, deputy: FactoryGirl.create(:user), contact: FactoryGirl.create(:contact))
      @user = @research_institute.deputy
      @company = FactoryGirl.create(:company, research_institute: @research_institute, contact: FactoryGirl.create(:contact))
      @user.research_institutes << @research_institute
      @discussion = FactoryGirl.create(:discussion)
      @discussion.moderator = @user
      sign_out @user
    end
    context "should be redirected to the signin page" do
      describe "get" do
        it "index" do
          get :index
          response.should redirect_to(new_user_session_url)
        end
        it "show" do
          get :show, {:id => @discussion.to_param}
          response.should redirect_to(new_user_session_url)
        end
        it "new" do
          get :new
          response.should redirect_to(new_user_session_url)
        end
        it "edit" do
          get :edit, {:id => @discussion.to_param}
          response.should redirect_to(new_user_session_url)
        end
      end
      describe "post" do
        it "create" do
          post :create, {discussion: valid_attributes}
          response.should redirect_to(new_user_session_url)
        end
      end
      describe "put" do
        it "update" do
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "" }}
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end
end
