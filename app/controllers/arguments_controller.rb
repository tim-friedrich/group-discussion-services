class ArgumentsController < ApplicationController
  before_filter :authenticate_user!

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
		@argument = Argument.new
    @argument.content = argument_params['content']
    @argument.discussion_id = argument_params['discussion_id']
    @argument.argument_type_id = ArgumentType.where(name: argument_params['type']).first.id
		@argument.user = current_user

    @argument.content = CGI::escapeHTML(@argument.content)
	  @argument.question = @argument.discussion.current_question

    if @argument.save
      argument_json = render_to_string( template: 'arguments/_argument.json.jbuilder', locals: { current_user: current_user, argument: @argument } )
      PrivatePub.publish_to "/discussion/"+@argument.discussion.id.to_s+"/arguments/new", JSON.parse(argument_json)
    end
  end

  def votes
    @votes = Argument.where(id: params[:id]).first().votes
    respond_to do |format|
      format.json
    end
  end

	def new
		@argument = Argument.new(argument_params)
    @argument.content = CGI::escapeHTML(@argument.content)
		@argument.user = current_user
		@argument.save
	end

	def argument_params
      	params.require(:argument).permit(:content, :user, :question, :type, :discussion_id, :user_id, :created_at, :likes, :dislikes, :question_id)
    end
    
    def check_rights
      	redirect_to signin_url, notice: "Bitte melden Sie sich an." unless signed_in?
    end
end
