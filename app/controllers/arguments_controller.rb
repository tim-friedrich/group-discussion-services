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
    @argument.content = CGI::escapeHTML(argument_params['content'])
    @argument.discussion_id = argument_params['discussion_id']
    @argument.argument_type_id = ArgumentType.where(name: argument_params['type']).first.id
		@argument.user = current_user
	  @argument.question = @argument.discussion.current_question

    if @argument.save
      discussion_user = DiscussionsUser.where(discussion_id: @argument.discussion.id, user_id: current_user.id).first()
      argument_json = render_to_string( template: 'arguments/_argument.json.jbuilder', locals: { current_user: current_user, argument: @argument } )
      if @argument.argument_type.name == 'observer'
        #or discussion_user.role.name == 'moderator' or discussion_user.role.name == 'observer'
        PrivatePub.publish_to "/discussion/"+@argument.discussion.id.to_s+"/observer/arguments/new", JSON.parse(argument_json)
      else
        PrivatePub.publish_to "/discussion/"+@argument.discussion.id.to_s+"/arguments/new", JSON.parse(argument_json)
      end

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
