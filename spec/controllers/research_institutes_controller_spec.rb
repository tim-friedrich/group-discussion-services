require 'spec_helper'

RSpec.describe ResearchInstitutesController, :type => :controller do
  let(:user){ FactoryGirl.create(:moderator) }

  before do
    sign_in user
  end

  let(:valid_attributes) { FactoryGirl.attributes_for(:research_institute).merge(contact_attributes: FactoryGirl.attributes_for(:contact)).merge(
    deputy_attributes: FactoryGirl.attributes_for(:user)) }
  let(:invalid_attributes) {  }
  let(:valid_session) { {} }


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
      research_institute.deputy = user
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
    end
  end
end
