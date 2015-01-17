class DiscussionsUsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :new_discussions_user, only: [ :create ]
  before_action :set_discussions_user, only: [:destroy, :confirm]
  load_and_authorize_resource
  check_authorization

 	def new
 		@discussion_user = DiscussionsUser.new
  end

  def confirm
    @discussions_user.confirmed = true
    if @discussions_user.save
      redirect_to user_path current_user
    else
      render nothing: true
    end
  end

 	def create
    if @discussions_user.save
      puts "b"*100
      puts UserMailer.invitation_to_discussion(@discussions_user).deliver
    else
      render nothing: true
    end
	end

	def destroy

	 	@discussions_user.destroy
	    respond_to do |format|
	      format.html { render nothing: true }
	      format.json { render nothing: true }
	    end
	end

	private

    def set_discussions_user
      @discussions_user = DiscussionsUser.find(params[:id])
    end
		def discussion_user_params
	  	params.require(:discussions_user).permit(:discussion_id, :user_id, :discussion, :user, :role_id)
    end

    def new_discussions_user
      @discussions_user = DiscussionsUser.new(discussion_user_params)
    end
end
