class UsersController < ApplicationController
  before_action :set_user
  before_filter :authenticate_user!
  load_and_authorize_resource


  def show
  end

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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end

  def index
    respond_to do |format|
      format.json do
        if current_user.is_deputy?
          @users = current_user.deputy_institute.users
          puts current_user.deputy_institute.users.to_yaml
        end
      end
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
