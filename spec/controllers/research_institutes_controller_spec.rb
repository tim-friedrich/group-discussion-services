require 'spec_helper'

RSpec.describe ResearchInstitutesController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  let(:valid_attributes) { FactoryGirl.attributes_for(:research_institute).merge(contact_attributes: FactoryGirl.attributes_for(:contact)).merge(
    deputy_attributes: FactoryGirl.attributes_for(:user)) }
  let(:invalid_attributes) {  }
  let(:valid_session) { {} }


  describe "GET index" do
    it "assigns all research_institutes as @research_institutes" do
      research_institute = ResearchInstitute.create! valid_attributes
      get :index, {}, valid_session
      assigns(:research_institutes).should eq([research_institute])
    end
  end

  describe "GET show" do
    it "assigns the requested research_institute as @research_institute" do
      research_institute = ResearchInstitute.create! valid_attributes
      get :show, {:id => research_institute.to_param}, valid_session
      assigns(:research_institute).should eq(research_institute)
    end
  end

  describe "GET new" do
    it "assigns a new research_institute as @research_institute" do
      get :new, {}, valid_session
      assigns(:research_institute).should be_a_new(ResearchInstitute)
    end
  end

  describe "GET edit" do
    it "assigns the requested research_institute as @research_institute" do
      research_institute = ResearchInstitute.create! valid_attributes
      research_institute.deputy = @user
      get :edit, {:id => research_institute.to_param}, valid_session
      assigns(:research_institute).should eq(research_institute)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ResearchInstitute" do
        expect {
          post :create, {:research_institute => valid_attributes}, valid_session
        }.to change(ResearchInstitute, :count).by(1)
      end

      it "assigns a newly created research_institute as @research_institute" do
        post :create, {:research_institute => valid_attributes}, valid_session
        assigns(:research_institute).should be_a(ResearchInstitute)
        assigns(:research_institute).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved research_institute as @research_institute" do
        # Trigger the behavior that occurs when invalid params are submitted
        ResearchInstitute.any_instance.stub(:save).and_return(false)
        post :create, {:research_institute => { "name" => "invalid value", contact_attributes: { }, deputy_attributes: {  } }}, valid_session
        assigns(:research_institute).should be_a_new(ResearchInstitute)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ResearchInstitute.any_instance.stub(:save).and_return(false)
        post :create, {:research_institute => { "name" => "invalid value", contact_attributes: { }, deputy_attributes: {  } } }, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested research_institute" do
        research_institute = ResearchInstitute.create! valid_attributes
        # Assuming there are no other research_institutes in the database, this
        # specifies that the ResearchInstitute created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ResearchInstitute.any_instance.should_receive(:update).with({ "name" => "" })
        put :update, {:id => research_institute.to_param, :research_institute => { "name" => "" }}, valid_session
      end

      it "assigns the requested research_institute as @research_institute" do
        research_institute = ResearchInstitute.create! valid_attributes
        put :update, {:id => research_institute.to_param, :research_institute => valid_attributes}, valid_session
        assigns(:research_institute).should eq(research_institute)
      end
    end

    describe "with invalid params" do
      it "assigns the research_institute as @research_institute" do
        research_institute = ResearchInstitute.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ResearchInstitute.any_instance.stub(:save).and_return(false)
        put :update, {:id => research_institute.to_param, :research_institute => { "name" => "invalid value" }}, valid_session
        assigns(:research_institute).should eq(research_institute)
      end

      it "re-renders the 'edit' template" do
        research_institute = ResearchInstitute.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ResearchInstitute.any_instance.stub(:save).and_return(false)
        put :update, {:id => research_institute.to_param, :research_institute => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested research_institute" do
      research_institute = ResearchInstitute.create! valid_attributes
      expect {
        delete :destroy, {:id => research_institute.to_param}, valid_session
      }.to change(ResearchInstitute, :count).by(-1)
    end
  end

end
