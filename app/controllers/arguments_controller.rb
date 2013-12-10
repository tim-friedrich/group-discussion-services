class ArgumentsController < ApplicationController
	before_action :check_rights

	def index 
		@arguments = Argument.all
	end

	def create 

		@argument = Argument.new(argument_params)
		@argument.user = current_user
		if @argument.save
			Pusher['discussion'+@argument.question.discussion.id.to_s].trigger('newargument', {
	  			firstname: @argument.user.firstName.to_s,
	  			argument: @argument.content.to_s,
	  			created_at: @argument.created_at.strftime("%H:%M").to_s
  			})
		end
	end

	def new

		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save
	end

	def argument_params
      	params.require(:argument).permit(:content, :user, :question, :user_id, :created_at, :likes, :dislikes, :question_id)
    end
    def check_rights
      redirect_to signin_url, notice: "Bitte melden Sie sich an." unless signed_in?
    end
end
