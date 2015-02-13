class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy, :index]


  load_and_authorize_resource


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  def profile
    @user = current_user
    @discussions_users = current_user.discussions_users.paginate(:page => params[:discussions_page], :per_page => 10)

    if current_user.research_institutes.first
      @companies = current_user.research_institutes.first.companies
    else
      @companies = Company.where(:id => nil).where("id IS NOT ?", nil)
    end
    @companies = @companies.paginate(:page => params[:companies_page], :per_page => 10)

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  # GET /users/new
  def new
    sign_out
    reset_session
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    byebug
    @user = User.new(user_params)
    @role = Role.where(name: 'user').first

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/profile', notice: 'Ihr Benutzer Konto wurde erfolgreich angelegt.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user, :bypass=>true)
        format.html { redirect_to '/profile', notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :discussions, :username)
    end
end
