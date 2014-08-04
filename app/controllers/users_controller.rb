class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    check_rights
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @discussions = @user.discussions
    @companies = Company.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    check_rights
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    puts user_params
    @role = Role.where(name: 'user').first

    respond_to do |format|
      if @user.save
        #sign_in @user
        format.html { redirect_to @user, notice: 'Ihr Benutzer Konto wurde erfolgreich angelegt.' }
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
    check_rights
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
    check_rights
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
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

    # Before filters
    
    def check_rights
      redirect_to signin_url, notice: "Bitte melden Sie sich an." unless signed_in?
    end
end
