class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new_customer]
  before_filter :authenticate_user!, except: [:new_customer]
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html{ forbidden }
      format.json{
        @users = User.where(role: Role.proband)
      }
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user, :bypass=>true)
        format.html { redirect_to '/profile', notice: 'Ihr Profil wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_customer
    @user = User.new
    @user.role = Role.customer
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*SETTINGS[:good_user_params])
  end
end
