require 'spec_helper'


RSpec.describe DiscussionsController, :type => :controller do
  let(:valid_session){ nil }
  let(:valid_attributes){
    F.attributes_for(:discussion, company_id: F.create(:company).id)
  }

  describe "signed in" do
    before do
      @user = F.build(:moderator)
      @research_institute = F.create(:research_institute, deputy: @user, contact: F.build(:contact))
      @company = F.create(:company, research_institute: @research_institute, contact: F.build(:contact))
      # @user.research_institutes << @research_institute
      @user.save
      sign_in @user
    end

    describe "GET" do
      describe "show" do
        it "assigns the requested discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          discussion.moderator = @user
          discussion.save
          get :show, {:id => discussion.to_param}, valid_session
          assigns(:discussion).should eq(discussion)
        end

        it "should be allowed to access a discussion that one is assigned for" do
          discussion = Discussion.create! valid_attributes
          discussion.moderator = @user
          discussion.save
          @proband = build(:user)
          discussion.users << @proband
          sign_in @proband
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
          discussion.moderator=@user
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
          discussion.moderator = @user
          discussion.save
          # Assuming there are no other discussions in the database, this
          # specifies that the Discussion created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Discussion.any_instance.should_receive(:update).with({ "topic" => "" })
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "" }}, valid_session
        end

        it "assigns the requested discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          discussion.moderator = @user
          put :update, {:id => discussion.to_param, :discussion => valid_attributes}, valid_session
          assigns(:discussion).should eq(discussion)
        end

        it "redirects to the user profile" do
          discussion = Discussion.create! valid_attributes

          discussion.moderator = @user

          put :update, {:id => discussion.to_param, :discussion => valid_attributes}, valid_session
          response.should redirect_to profile_path
        end
      end

      describe "with invalid params" do
        it "assigns the discussion as @discussion" do
          discussion = Discussion.create! valid_attributes
          discussion.moderator = @user
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "invalid value" }}, valid_session
          assigns(:discussion).should eq(discussion)
        end

        it "re-renders the edit template" do
          discussion = Discussion.create! valid_attributes
          discussion.moderator = @user
          discussion.save()
          # Trigger the behavior that occurs when invalid params are submitted
          Discussion.any_instance.stub(:save).and_return(false)
          put :update, {:id => discussion.to_param, :discussion => { "topic" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end
  end
end
