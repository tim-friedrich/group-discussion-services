class DiscussionsUsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :new_discussion_user, only: [ :create ]
  load_and_authorize_resource
  check_authorization

 	def new
 		@discussion_user = DiscussionsUser.new

 	end

 	def create
    puts "Z"*30
	    respond_to do |format|
	      if @discussions_user.save
          puts "b"*100
          puts UserMailer.invitation_to_discussion(@discussions_user).deliver
	        format.js { puts "a"*100 }

        else
          puts "fail"*40
        end
	    end
	end

	def destroy
		@discussions_user = DiscussionsUser.find(params[:id])
	 	@discussions_user.destroy
	    respond_to do |format|
	      format.html { render nothing: true }
	      format.json { render nothing: true }
	    end
	end

	private
		def discussion_user_params
	  	params.require(:discussions_user).permit(:discussion_id, :user_id, :discussion, :user, :role_id)
    end

    def new_discussion_user
      @discussions_user = DiscussionsUser.new(discussion_user_params)
    end
end
