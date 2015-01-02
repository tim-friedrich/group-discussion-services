class VisualAidsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_visual_aid, only: [ :open, :destroy, :close, :command ]

  def create
    @visual_aid = VisualAid.new(visual_aid_params)

    respond_to do |format|
      if @visual_aid.save

        format.html { render nothing: true }
        format.json {  }
      else
        format.html { render nothing: true, status: :bad_request }
        format.json { render nothing: true, status: :bad_request }
      end
    end
  end

  def destroy
    if current_user == @visual_aid.discussion.moderator
      # enumerate at most 20 objects with the given prefix
      S3_BUCKET.objects.each do | file |
        if file.key == @visual_aid.url.split('/')[3..-1].join('/')
          file.delete()
        end
      end
      @visual_aid.destroy
      respond_to do |format|
        format.html { render nothing: true }
        format.json { render nothing: true }
      end
    else
      render nothing: true, status: :forbidden
    end
  end

  def open
    if current_user.id == @visual_aid.discussion.moderator.id
      PrivatePub.publish_to "/discussion/"+@visual_aid.discussion.id.to_s+"/visualAid/open", JSON.parse(@visual_aid.to_json())
      @visual_aids_log = VisualAidsLog.new(visual_aid_id: @visual_aid.id, open: true)
      @visual_aids_log.save()
      @visual_aid.visual_aids_logs << @visual_aids_log
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json {  }
    end
  end

  def command
    if current_user.id == @visual_aid.discussion.moderator.id
      PrivatePub.publish_to "/discussion/"+@visual_aid.discussion.id.to_s+"/visualAid/command", JSON.parse({
        id: @visual_aid.id,
        command: params[:command],
        params: params[:params]
        }.to_json)
      #@visual_aids_log = VisualAidsLog.new(visual_aid_id: @visual_aid.id, open: true)
      #@visual_aids_log.save()
      # @visual_aid.visual_aids_logs << @visual_aids_log
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json {  }
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
      format.json {  }
    end
  end

  private

  def visual_aid_params
    params.require(:visual_aid).permit(:discussion_id, :url, :name, :media_type, :command)
  end
  def set_visual_aid
    @visual_aid = VisualAid.find(params[:id])
  end
end
