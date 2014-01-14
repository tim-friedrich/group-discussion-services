class ArgumentsController < ApplicationController
	before_action :check_rights
	def show
		@argument = Argument.where(id: params[:id]).first
		@moderator_type = ArgumentType.where(name: 'moderator').first
		respond_to do | format |
			format.js
		end
	end

	def argument
		@moderator_type = ArgumentType.where(name:'moderator').first 
	end
	
	def create 
		
		if params[:commit]!="Neue Frage" 
			@argument = Argument.new(argument_params)
			@argument.user = current_user
			
	    	@argument.question = @argument.discussion.current_question
	    	set_argument_type(@argument)
			if @argument.save
				Pusher['discussion'+@argument.discussion.id.to_s].trigger('newArgument', {
		  			firstname: @argument.user.firstname.to_s,
		  			argument: @argument.content.to_s,
		  			created_at: @argument.created_at.strftime("%H:%M").to_s,
		  			argument_type: @argument.argument_type.name.to_s,
		  			id: @argument.id,
		  			obj: @argument
	  			})
			end
		else
			@question = Question.new
			@question.topic = argument_params[:content]
			@question.discussion_id = argument_params[:discussion_id]

			@question.discussion.current_question = @question
			@question.discussion.save

			if @question.save

				Pusher['discussion'+@question.discussion.id.to_s].trigger('newQuestion', {
					topic: @question.topic
				})
			end
		end
	end

	def new
		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save
	end

	def argument_params
      	params.require(:argument).permit(:content, :user, :question, :discussion_id, :user_id, :created_at, :likes, :dislikes, :question_id)
    end
    def check_rights
      	redirect_to signin_url, notice: "Bitte melden Sie sich an." unless signed_in?
    end

    private

    	def set_argument_type (argument)
	   		if (argument.discussion.moderator == current_user)
				argument.argument_type = ArgumentType.where(name: 'moderator').first
			else
				argument.argument_type = ArgumentType.where(name: 'proband').first
			end
		end
end
