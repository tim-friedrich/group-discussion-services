class ArgumentsController < ApplicationController
	def index 
		@arguments = Argument.all
	end

	def create 

		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save
		Pusher['discussion'+@argument.question.discussion.id.to_s].trigger('new_argument', {
  			firstname: @argument.user.firstName.to_s,
  			argument: @argument.content.to_s,
  			created_at: @argument.created_at.strftime("%H:%M").to_s
})
		render action: 'new'
	end

	def new

		@argument = Argument.new(argument_params)
		@argument.user = current_user
		@argument.save


		render action: 'new'
	end

	def argument_params
      	params.require(:argument).permit(:content, :user, :question, :user_id, :created_at, :likes, :dislikes, :question_id)
    end

end
