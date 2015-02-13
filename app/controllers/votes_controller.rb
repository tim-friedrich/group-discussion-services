class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :new_vote, only: [ :create ]


  load_and_authorize_resource
  skip_authorization_check # FIXME why?


  # POST /votes
  # POST /votes.json
  def create

    respond_to do |format|
      if @vote.save
        PrivatePub.publish_to "/discussion/"+@vote.argument.discussion.id.to_s+"/votes/new", @vote
        format.html { }
        format.json { }
      else
        format.html { }
        format.json { }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:argument_id, :user_id, :is_like)
    end

    def new_vote
      @vote = Vote.new(vote_params)
      @vote.user = current_user
    end
end
