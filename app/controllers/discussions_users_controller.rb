class DiscussionUsersController < ApplicationController
 	def new
 		@discussion_user = DiscussionUser.new
 	end

 	def create
	    @discussion_user = DiscussionUser.new(discussion_user_params)
	    respond_to do |format|
	      if @discussion_user.save
	        format.js {}
	      end
	    end
	end

	def destroy
		@discussion_user = DiscussionUser.find(params[:id])
	 	@discussion_user.destroy
	    respond_to do |format|
	      format.html {  }
	      format.json {  }
	    end
	end

	private
		def discussion_user_params
	      	params.require(:discussion_user).permit(:discussion_id, :user_id, :discussion, :user)
	    end
end
