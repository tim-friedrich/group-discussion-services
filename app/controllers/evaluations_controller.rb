class EvaluationsController < ApplicationController
  before_action :set_discussion
  before_filter :authenticate_user!
  load_and_authorize_resource :discussion


  def show
    respond_to do |format|
      format.pdf do
        ensure_user_chart_images!
      end

      format.text do
        render text: "bla"
      end

      format.html do
        render 'show'
      end
    end
  end


  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def ensure_user_chart_images!
    @discussion.users.includes(:survey).each{ |user|
      user.ensure_chart_image!
    }
  end
end
