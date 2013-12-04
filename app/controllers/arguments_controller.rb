class ArgumentsController < ApplicationController
	def index 
		@arguments = Argument.all
	end

	def create 
		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save
		render action: 'new'
	end

	def new
			
		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save
		 	respond_to do |f|
	    	f.js
	    end
		render action: 'new'
	end

	def argument_params
      	params.require(:argument).permit(:content, :user, :question, :user_id, :created_at, :likes, :dislikes, :question_id)
    end

end
