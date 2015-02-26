class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :new_company, only: :create


  load_and_authorize_resource


  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.contact = Contact.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    respond_to do |format|
      if @company.save
        format.html { redirect_to '/profile', notice: 'Das Unternehmen wurde erfolgreich angelegt.' }
        format.json { render action: 'show', status: :created, location: @company }
      else
        format.html { render action: 'new' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to '/profile', notice: 'Das Unternehmen wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to '/profile' }
      format.json { head :no_content }
    end
  end


  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, contact_attributes: [:street, :postalcode, :town, :email, :telephone])
  end

  def new_company
    @company = Company.new(company_params)
    @company.research_institute = current_user.research_institutes.first
  end
end
