class ArgumentsController < ApplicationController
	before_action :check_rights

	def create 
		@argument = Argument.new(argument_params)
		@argument.user = current_user
		set_argument_type(@argument)
    	

		if @argument.save
			Pusher['discussion'+@argument.question.discussion.id.to_s].trigger('newargument', {
	  			firstname: @argument.user.firstName.to_s,
	  			argument: @argument.content.to_s,
	  			created_at: @argument.created_at.strftime("%H:%M").to_s,
	  			argument_type: @argument.argument_type.name.to_s
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

    private

    	def set_argument_type (argument)
	   		if (argument.question.discussion.moderator == current_user)
				argument.argument_type = ArgumentType.where(name: 'moderator').first
			else
				argument.argument_type = ArgumentType.where(name: 'proband').first
			end
		end
end
