class VisualAidsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_visual_aid, only: [ :open, :destroy, :close, :command ]
  before_action :new_visual_aid, only: [ :create ]
  load_and_authorize_resource
  check_authorization

  def create
    respond_to do |format|
      if @visual_aid.save
        format.html { render nothing: true }
        format.json {  }
        format.js do
          @total_pages = @visual_aid.discussion.visual_aids.paginate(:page => 1, :per_page => 10).total_pages
          @visual_aids = @visual_aid.discussion.visual_aids.paginate(:page => @total_pages, :per_page => 10)
        end
      else
        format.html { render nothing: true, status: :bad_request }
        format.json { render nothing: true, status: :bad_request }
      end
    end
  end

  def destroy
    if current_user == @visual_aid.discussion.moderator
      @visual_aid.destroy
      respond_to do |format|
        format.html { render nothing: true }
        format.json { render nothing: true }
      end
    else
      render nothing: true, status: :forbidden
    end
  end

  def command
    if current_user.id == @visual_aid.discussion.moderator.id
      PrivatePub.publish_to "/discussion/"+@visual_aid.discussion.id.to_s+"/visualAid/command", JSON.parse({
        id: @visual_aid.id,
        command: params[:command],
        params: params[:params]
        }.to_json)
      write_log(true) if params[:command] == 'open'
      write_log(false) if params[:command] == 'close'
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json {  }
    end
  end

  private

  def visual_aid_params
    params.require(:visual_aid).permit(:discussion_id, :name, :command, :file)
  end
  def set_visual_aid
    @visual_aid = VisualAid.find(params[:id])
  end

  def new_visual_aid
    puts visual_aid_params.to_yaml
    @visual_aid = VisualAid.new(visual_aid_params)
  end

  def write_log(open)
    @visual_aids_log = VisualAidsLog.new(visual_aid_id: @visual_aid.id, open: open)
    @visual_aids_log.save()
    @visual_aid.visual_aids_logs << @visual_aids_log
  end

end
