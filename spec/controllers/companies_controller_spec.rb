require 'spec_helper'


RSpec.describe CompaniesController, :type => :controller do

  before do
    @research_institute = FactoryGirl.create(:research_institute, deputy: FactoryGirl.create(:user), contact: FactoryGirl.create(:contact))
    @research_institute.deputy.role = Role.where(name: 'moderator').first()
    @research_institute.deputy.save()
    sign_in @research_institute.deputy
  end
  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:company).merge( contact_attributes: FactoryGirl.attributes_for(:contact) ) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, {:id => company.to_param}, valid_session
      assigns(:company).should eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      get :new, {}, valid_session
      assigns(:company).should be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, {:id => company.to_param}, valid_session
      assigns(:company).should eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, {:company => valid_attributes}, valid_session
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, {:company => valid_attributes}, valid_session
        assigns(:company).should be_a(Company)
        assigns(:company).should be_persisted
      end

      it "redirects to the user profile" do
        post :create, {:company => valid_attributes}, valid_session
        response.should redirect_to profile_path
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        post :create, {:company => { "name" => "invalid value", contact_attributes: { } }}, valid_session
        assigns(:company).should be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        post :create, {:company => { "name" => "invalid value", contact_attributes: { } }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested company" do
        company = Company.create! valid_attributes
        # Assuming there are no other companies in the database, this
        # specifies that the Company created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Company.any_instance.should_receive(:update).with({ "name" => "" })
        put :update, {:id => company.to_param, :company => { "name" => "" }}, valid_session
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
        assigns(:company).should eq(company)
      end

      it "redirects to the user profile" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => valid_attributes}, valid_session
        response.should redirect_to profile_path
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        put :update, {:id => company.to_param, :company => { "name" => "invalid value" }}, valid_session
        assigns(:company).should eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        put :update, {:id => company.to_param, :company => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, {:id => company.to_param}, valid_session
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the users profile" do
      company = Company.create! valid_attributes
      delete :destroy, {:id => company.to_param}, valid_session
      response.should redirect_to profile_path
    end
  end

end
