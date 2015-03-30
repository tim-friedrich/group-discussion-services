class ResearchInstitutesController < ApplicationController
  before_action :set_research_institute, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :new_research_institute, only: :create
  load_and_authorize_resource


  def show
  end

  def new
    @research_institute = ResearchInstitute.new contact: Contact.new, deputy: User.new
    # @deputy = User.new
    # @research_institute.deputy = @deputy
  end

  def edit
  end

  def create
    respond_to do |format|
      if @research_institute.save
        sign_in @research_institute.deputy
        format.html { redirect_to '/profile', notice: 'Herzlich Willkommen!.' }
        format.json { render action: 'show', status: :created, location: @research_institute }
      else
        format.html { render action: 'new' }
        format.json { render json: @research_institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @research_institute.update(research_institute_params)
        format.html { redirect_to '/profile', notice: 'Research institute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @research_institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @research_institute.destroy
    respond_to do |format|
      format.html { redirect_to '/profile' }
      format.json { head :no_content }
    end
  end


  private

  def set_research_institute
    @research_institute = ResearchInstitute.find(params[:id])
  end

  def research_institute_params
    params.require(:research_institute).permit(:name, :deputy,
      deputy_attributes: SETTINGS[:good_user_params],
      contact_attributes: [:street, :postalcode, :town, :email, :telephone])
  end

  def new_research_institute
    @research_institute = ResearchInstitute.new(research_institute_params)
    @research_institute.users << @research_institute.deputy
    @research_institute.deputy.role = Role.moderator
  end
end
