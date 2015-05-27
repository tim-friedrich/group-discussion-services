class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user
  load_and_authorize_resource :discussion

  def show
    if current_user.is_admin?
      @discussions = Discussion.all.paginate(page: params[:discussions_page], per_page: 10)
    else
      @discussions_users = @user.in_discussions.paginate(page: params[:discussions_page], per_page: 10) 
    end
  end

  private

  def set_user
    @user = current_user
  end
end