class ResearchInstitutesController < ApplicationController
  before_action :set_research_institute, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :new_research_institute, only: :create


  load_and_authorize_resource


  # GET /research_institutes
  # GET /research_institutes.json
  def index
    @research_institutes = ResearchInstitute.all
  end

  # GET /research_institutes/1
  # GET /research_institutes/1.json
  def show
  end

  # GET /research_institutes/new
  def new
    @research_institute = ResearchInstitute.new
    @research_institute.contact = Contact.new
    @deputy = User.new
    @research_institute.deputy = @deputy

  end

  # GET /research_institutes/1/edit
  def edit
  end

  # POST /research_institutes
  # POST /research_institutes.json
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

  # PATCH/PUT /research_institutes/1
  # PATCH/PUT /research_institutes/1.json
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

  # DELETE /research_institutes/1
  # DELETE /research_institutes/1.json
  def destroy
    @research_institute.destroy
    respond_to do |format|
      format.html { redirect_to '/profile' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research_institute
      @research_institute = ResearchInstitute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def research_institute_params
      params.require(:research_institute).permit(:name, :deputy,
        deputy_attributes: [:username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_token, :discussions],
        contact_attributes: [:street, :postalcode, :town, :email, :telephone])
    end

    def new_research_institute
      @research_institute = ResearchInstitute.new(research_institute_params)
      @research_institute.users << @research_institute.deputy
      @research_institute.deputy.role = Role.where(name: "moderator").first
    end
end
