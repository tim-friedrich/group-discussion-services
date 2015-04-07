class DiscussionsUsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_discussions_user, only: [:destroy, :confirm]
  load_and_authorize_resource


  def index_by_discussion
    @discussions_users = DiscussionsUser.where(discussion_id: params[:id]).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.json { render json: JSON.parse(render_to_string( template: 'discussions_users/_user.json.jbuilder', locals: { discussions_user: @discussions_users })) }
    end
  end

  def confirm
    @discussions_user.confirmed = true
    if @discussions_user.save
      @json = render_to_string( template: 'discussions_users/_user.json.jbuilder', locals: { discussions_user: @discussions_user })
      PrivatePub.publish_to "/discussion/#{@discussions_user.discussion.id}/users/new", JSON.parse(@json)
      redirect_to '/profile'
    else
      render nothing: true
    end
  end

  def destroy
    @discussions_user.destroy
    set_update_list_params
    render 'discussions_users/update_lists'
  end


  private

  def set_discussions_user
    @discussions_user = DiscussionsUser.find(params[:id])
  end

  def set_update_list_params
    @probands  = @discussions_user.discussion.probands.paginate(page: params[:probands_page], per_page: 10)
    @observers = @discussions_user.discussion.observers.paginate(page: params[:observers_page], per_page: 10)
  end
end
