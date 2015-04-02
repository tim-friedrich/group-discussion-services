class DiscussionsController < ApplicationController
  before_action :set_discussion, except: [:new, :create]
  before_filter :authenticate_user!
  load_and_authorize_resource


  def show
    respond_to do |format|
      if !current_user.is_part_of_discussion?(@discussion)
        format.html{ redirect_to '/profile', notice: "Du bist nicht für diese Diskussion eingetragen" }
        format.json{ render status: :forbidden }
      elsif @discussion.closed?
        format.html{ redirect_to '/profile', notice: "Diese Diskussion ist geschlossen" }
        format.json{ render status: :forbidden }
      else
        @discussion_user = @discussion.discussions_user_for(current_user)
        current_user.enter_discussion(@discussion)
        PrivatePub.publish_to "/discussion/#{@discussion.id}/users/enter", user_id: current_user.id

        format.html{ @questions = Question.where(discussion_id: params[:id]) }
        format.json do
          @discussions_user = []
          @discussion.discussions_users.each do |discussions_user|
            if discussions_user.confirmed
              @discussions_user << discussions_user
            end
          end
          @visual_aids_log = VisualAidsLog.where('visual_aid_id in (:visual_aids)', { visual_aids: @discussion.visual_aids.to_a.map(&:id) } )
          if current_user == @discussion.moderator or @discussion_user.role.name == 'observer'
            @arguments = @discussion.arguments.includes(:argument_type)
            @votes = Vote.where('argument_id in (:arguments)', { arguments: @arguments.to_a.map(&:id) })

          else
            @arguments = []

            @discussion.arguments.each do | argument |
              if argument.argument_type.name == 'proband' or argument.argument_type.name == 'moderator'
                @arguments.push(argument)
              end
            end
            @votes = Vote.where('argument_id in (:arguments) and user_id = :user', {arguments: @arguments.to_a.map(&:id), user: current_user})
          end
        end
      end
    end
  end

  def leave
    current_user.leave_discussion(@discussion)
    PrivatePub.publish_to "/discussion/#{@discussion.id}/users/leave", user_id: current_user.id
    render nothing: true
  end

  def new
    @discussion = Discussion.new
    @users = User.all
    @proband = DiscussionsUser.new
    if current_user.research_institutes.first
      @companies = current_user.research_institutes.first.companies
    else
      @companies = []
    end
  end

  def edit
    @probands    = @discussion.probands.paginate(page: params[:probands_page], per_page: 10)
    @observers   = @discussion.observers.paginate(page: params[:observers_page], per_page: 10)
    @visual_aids = @discussion.visual_aids.paginate(page: params[:visual_aids_page], per_page: 10)

    respond_to do |format|
      format.html do
        session[:return_to] = profile_path
        @survey_texts = JSON.load(Rails.root.join 'db/survey_analysis_texts.json')
        @companies = current_user.research_companies
        @proband = DiscussionsUser.new role: Role.proband
        @visual_aid = VisualAid.new
        @users = User.all
        @user = User.new
      end
      format.js do
        if @discussion.errors
          render json: @discussion.errors
        end
      end
    end
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @question = Question.create(topic: "Herzlich Willkommen", discussion: @discussion)

    respond_to do |format|
      if @discussion.save
        @discussion.moderator = current_user
        @question.save
        format.html { redirect_to edit_discussion_path(@discussion) }
        format.json { render action: 'show', status: :created, location: @discussion }
      else
        format.html { render action: 'new' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to(session.delete(:return_to) || profile_path, notice: 'Die Diskussion wurde erfolgreich aktualisiert.') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    DiscussionsUser.where(discussion_id: @discussion.id).destroy_all
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to '/profile' }
      format.json { head :no_content }
    end
  end

  def arguments
    respond_to do | format |
      format.json{ render json: @discussion.arguments }
      format.html{ render json: @discussion.arguments }
    end
  end


  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:topic, :moderator, :due_date, :moderator_id, :users, :company_id, :company, :visual_aids, :summary)
  end
end
