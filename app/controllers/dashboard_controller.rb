class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user
  load_and_authorize_resource :discussion

  def show
    @discussions_users = @user.in_discussions.paginate(page: params[:discussions_page], per_page: 10)
    @companies = Company.all
    @companies = @companies.paginate(page: params[:companies_page], per_page: 10)
  end


  private

  def set_user
    @user = current_user
  end
end