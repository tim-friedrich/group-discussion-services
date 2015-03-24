class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :new_company, only: :create
  load_and_authorize_resource


  def show
  end

  def new
    @company = Company.new contact: Contact.new
  end

  def edit
  end

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
    @company.research_institute = current_user.preferred_research_institute
  end
end
