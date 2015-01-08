class ArgumentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :new_argument, only: :create
  load_and_authorize_resource
  check_authorization

	def create
    if @argument.save
      argument_json = render_to_string( template: 'arguments/_argument.json.jbuilder', locals: { current_user: current_user, argument: @argument } )
      if @argument.argument_type.name == 'observer'
        PrivatePub.publish_to "/discussion/"+@argument.discussion.id.to_s+"/observer/arguments/new", JSON.parse(argument_json)
      else
        PrivatePub.publish_to "/discussion/"+@argument.discussion.id.to_s+"/arguments/new", JSON.parse(argument_json)
      end
    end
    render nothing: true
  end

	def argument_params
  	params.require(:argument).permit(:content, :user, :question, :type, :discussion_id, :user_id, :created_at, :likes, :dislikes, :question_id)
  end

  def new_argument
    @argument = Argument.new
    @argument.content = CGI::escapeHTML(argument_params['content'])
    @argument.discussion_id = argument_params['discussion_id']
    @argument.argument_type_id = ArgumentType.where(name: argument_params['type']).first.id
    @argument.user = current_user
    @argument.question = @argument.discussion.current_question
  end
end
