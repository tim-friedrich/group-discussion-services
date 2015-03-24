class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :new_question
  load_and_authorize_resource
  skip_authorization_check # FIXME why?


  def create
    respond_to do |format|
      if @question.save
        @question.discussion.save
        PrivatePub.publish_to "/discussion/#{@question.discussion.id}/questions/new", topic: @question.topic
        format.html { render nothing: true }
        format.json { render nothing: true }
      else
        format.html { render nothing: true }
        format.json { render nothing: true }
      end
    end
  end


  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:topic, :description, :discussion_id)
  end

  def new_question
    @question = Question.new(question_params)
    @question.topic = CGI::escapeHTML(@question.topic)
  end
end
