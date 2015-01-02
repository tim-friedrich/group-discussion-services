class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.topic = CGI::escapeHTML(@question.topic)
    respond_to do |format|
      if @question.save
        @question.discussion.save
        PrivatePub.publish_to "/discussion/"+@question.discussion.id.to_s+"/questions/new", topic: @question.topic
        format.html { render nothing: true }
        format.json { render nothing: true }
      else
        format.html { render nothing: true }
        format.json { render nothing: true }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:topic, :description, :discussion_id)
    end
end
