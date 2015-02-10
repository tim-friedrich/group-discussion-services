class HomeController < ApplicationController
  def show
    if current_user
      redirect_to '/profile'
    end
  end
end
