class DiscussionUsersController < ApplicationController
 	def new
 		@discussion_user = DiscussionUser.new
 	end

 	def create
	    @discussion_user = DiscussionUser.new(discussion_user_params)

	    respond_to do |format|
	      if @discussion_user.save
	        format.js
	      end
	    end
	end


	def discussion_user_params
      	params.require(:discussion_user).permit(:discussion_id, :user_id, :discussion, :user)
    end
end
