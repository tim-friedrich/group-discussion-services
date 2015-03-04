class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:leave, :show, :edit, :update, :destroy, :evaluate, :arguments]
  before_action :new_discussion, only: [ :create ]
  before_filter :authenticate_user!


  load_and_authorize_resource


  def show
    respond_to do | format |
      if !current_user and !current_user.is_part_of_discussion?(@discussion)
        format.html{ redirect_to '/profile', notice: "Du bist nicht für diese Discussion eingetragen" }
        format.json{ render status: :forbidden }
      else
        @discussion_user = DiscussionsUser.where(discussion_id: @discussion.id, user_id: current_user).first()
        current_user.enter_discussion(@discussion)
        PrivatePub.publish_to "/discussion/"+@discussion.id.to_s+"/users/enter", user_id: current_user.id

        format.html{ @questions = Question.where(discussion_id: params[:id]) }
        format.json do

          @discussions_user = []
          @discussion.discussions_users.each do | discussions_user |
            if discussions_user.confirmed
              @discussions_user << discussions_user
            end
          end
          @visual_aids_log = VisualAidsLog.where('visual_aid_id in (:visual_aids)', { visual_aids: @discussion.visual_aids.to_a.map(&:id) } )
          if current_user == @discussion.moderator or @discussion_user.role.name == 'observer'
            @arguments = @discussion.arguments
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
    PrivatePub.publish_to "/discussion/"+@discussion.id.to_s+"/users/leave", user_id: current_user.id
    render nothing: true
  end

  def new
    @discussion = Discussion.new
    @users = User.all
    @proband = DiscussionsUser.new
    if current_user.research_institutes.first()
      @companies = current_user.research_institutes.first.companies
    else
      @companies = []
    end
  end

  def edit
    @proband_role =  Role.where(name: 'proband').first()
    @observer_role =  Role.where(name: 'observer').first()
    @probands = DiscussionsUser.where(discussion_id: @discussion.id, role_id: @proband_role.id).paginate(:page => params[:probands_page], :per_page => 10)
    @observers = DiscussionsUser.where(discussion_id: @discussion.id, role_id: @observer_role.id).paginate(:page => params[:observers_page], :per_page => 10)
    @visual_aids = @discussion.visual_aids.paginate(:page => params[:visual_aids_page], :per_page => 10)
    respond_to do |format|
      format.html do
        if current_user.research_institutes.first()
          @companies = current_user.research_institutes.first.companies
        else
          @companies = []
        end
        @proband = DiscussionsUser.new
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
        format.html { redirect_to '/profile', notice: 'Die Diskussion wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    DiscussionsUser.where(discussion_id: @discussion.id).delete_all
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to '/profile' }
      format.json { head :no_content }
    end
  end

  def evaluate
    respond_to do |format|
      format.html{}
      format.pdf{
        ensure_user_chart_images!
      }
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

  def new_discussion
    @discussion = Discussion.new(discussion_params)
    @question = Question.create(topic: "Herzlich Willkommen", discussion: @discussion)
  end

  def discussion_params
    params.require(:discussion).permit(:topic, :moderator, :due_date, :moderator_id, :users, :company_id, :company, :visual_aids, :summary)
  end

  def ensure_user_chart_images!
    @discussion.users.each{ |user|
      user.ensure_chart_image!
    }
  end
end
