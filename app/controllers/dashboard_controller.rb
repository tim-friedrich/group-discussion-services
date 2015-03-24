class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user
  # load_and_authorize_resource

  def show
    @discussions_users = @user.in_discussions.paginate(page: params[:discussions_page], per_page: 10)

    if @user.preferred_research_institute
      @companies = @user.preferred_research_institute.companies.includes(:contact)
    else
      @companies = Company.none
    end
    @companies = @companies.paginate(page: params[:companies_page], per_page: 10)
  end


  private

  def set_user
    @user = current_user
  end
end