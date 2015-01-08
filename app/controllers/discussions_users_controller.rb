class DiscussionsUsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :new_discussion_user, only: [ :create ]
  load_and_authorize_resource
  check_authorization

 	def new
 		@discussion_user = DiscussionsUser.new
 	end

 	def create
	    respond_to do |format|
	      if @discussions_user.save
	        format.js {  }
	      end
	    end
	end

	def destroy
		@discussions_user = DiscussionsUser.find(params[:id])
	 	@discussions_user.destroy
	    respond_to do |format|
	      format.html {  }
	      format.json {  }
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
