require 'cgi'

class ArgumentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :discussion


  def create
    discussion = current_user.discussions.find(argument_params['discussion_id'])

    @argument = Argument.new(
      content: CGI::escapeHTML(argument_params['content'].to_s),
      discussion: discussion,
      argument_type: ArgumentType.find_by_name(argument_params['type']),
      user: current_user,
      question: discussion.current_question,
    )

    if @argument.save
      argument_json = render_to_string(partial: 'arguments/argument.json.jbuilder', object: @argument)
      if @argument.argument_type.name == 'observer'
        PrivatePub.publish_to "/discussion/#{discussion.id}/observer/arguments/new", JSON.parse(argument_json)
      else
        PrivatePub.publish_to "/discussion/#{discussion.id}/arguments/new", JSON.parse(argument_json)
      end
    end
    render nothing: true
  end

  def argument_params
    params.require(:argument).permit(:content, :user, :question, :type, :discussion_id, :user_id, :created_at, :likes, :dislikes, :question_id)
  end
end
