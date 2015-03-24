class DiscussionStateController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_discussion
  before_filter :can_manage!


  def update
    @discussion.update_attributes(discussion_params)

    # TODO: why is explicitness necessary?
    response.headers['Content-Type'] = 'application/x-javascript'
    render action: 'update', formats: 'coffee'
  end


  private

  def discussion_params
    params.require(:discussion).permit(:state, :state_message)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  # TODO get this working with cancan
  def can_manage!
    unless current_user.can_manage_discussion? @discussion
      raise CanCan::AccessDenied, 'Sie dürfen diese Diskussion nicht bearbeiten'
    end
  end
end
