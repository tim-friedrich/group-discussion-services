class VisualAidsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @visual_aid = VisualAid.new(visual_aid_params)

    respond_to do |format|
      if @visual_aid.save
        format.html { render nothing: true }
        format.json { render nothing: true }
      else
        format.html { render nothing: true }
        format.json { render nothing: true }
      end
    end
  end

  def destroy
    #@visual_aid.destroy
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render nothing: true }
    end
  end

  private

  def visual_aid_params
    params.require(:visual_aid).permit(:discussion_id, :url)
  end

end
