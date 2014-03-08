class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:leave, :show, :edit, :update, :destroy, :evaluate]
  before_action :check_rights
  
  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show

    if !current_user.is_part_of_discussion?(@discussion)
      redirect_to discussions_url, notice: "Du bist nicht für diese Discussion eingetragen"
    else
      @questions = Question.where(discussion_id: params[:id])
      @type_proband = ArgumentType.where(name:'proband').first
      @type_moderator = ArgumentType.where(name:'moderator').first 
      current_user.enter_discussion(@discussion)
      @moderator_arguments = Argument.where(discussion_id: @discussion.id, argument_type: @type_moderator)
      @proband_arguments = Argument.where(discussion_id: @discussion.id, argument_type: @type_proband)
      Pusher['discussion'+@discussion.id.to_s].trigger('userEntered', {
        user_id: current_user.id
      })
    end
  end

  def leave
    current_user.leave_discussion(@discussion)

    Pusher['discussion'+@discussion.id.to_s].trigger('userLeaved', {
      user_id: current_user.id
    })
    render nothing: true
  end

  def user_leaved
    @user = User.find_by_id(params[:id])
    respond_to do | format |
      format.js
    end
  end

  def user_entered
    @user = User.find_by_id(params[:id])
    respond_to do | format |
      format.js
    end
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
    @users = User.all
    @proband = DiscussionsUser.new
    @companies = current_user.research_institutes.first.companies
    if @companies.empty?
      redirect_to new_company_path, notice: 'Bitte erstellen sie zuerst einen Kunden.'
    end
  end

  # GET /discussions/1/edit
  def edit
    @companies = current_user.research_institutes.first.companies
    @proband = DiscussionsUser.new
    @users = User.all
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.moderator = current_user
    @discussion.users << current_user
    @question = Question.create(topic: "Herzlich Willkommen", discussion: @discussion)

    @discussion.current_question = @question

    respond_to do |format|
      if @discussion.save
        @question.save;
        format.html { redirect_to current_user, notice: 'Eine neue Diskussion wurde erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @discussion }
      else
        format.html { render action: 'new' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to current_user, notice: 'Die Diskussion wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url }
      format.json { head :no_content }
    end
  end

  # GET /discussions/1/evaluate
  def evaluate
    puts 'A' * 50
    puts
    puts @discussion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:topic, :moderator, :due_date, :moderator_id, :users, :company_id, :company)
    end

    def check_rights
      redirect_to signin_url, notice: "Bitte melden Sie sich an." unless current_user == nil || signed_in?
    end
end
