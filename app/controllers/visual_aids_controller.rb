class VisualAidsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_visual_aid, only: [ :open, :destroy, :close ]

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

  def open
    if current_user.id == @visual_aid.discussion.moderator.id
      PrivatePub.publish_to "/discussion/"+@visual_aid.discussion.id.to_s+"/visualAid/open", JSON.parse(@visual_aid.to_json)
      @visual_aids_log = VisualAidsLog.new(visual_aid_id: @visual_aid.id, open: true)
      @visual_aids_log.save()
      @visual_aid.visual_aids_logs << @visual_aids_log
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render nothing: true }
    end
  end

  def close
    if current_user.id == @visual_aid.discussion.moderator.id
      PrivatePub.publish_to "/discussion/"+@visual_aid.discussion.id.to_s+"/visualAid/close", JSON.parse(@visual_aid.to_json)
      @visual_aids_log = VisualAidsLog.new(visual_aid_id: @visual_aid.id, open: false)
      @visual_aids_log.save()
      @visual_aid.visual_aids_logs << @visual_aids_log
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render nothing: true }
    end
  end

  private

  def visual_aid_params
    params.require(:visual_aid).permit(:discussion_id, :url)
  end
  def set_visual_aid
    @visual_aid = VisualAid.find(params[:id])
  end
end
