class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:leave, :show, :edit, :update, :destroy, :evaluate, :arguments]
  before_filter :authenticate_user!
  
  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    respond_to do | format |
      if !current_user and !current_user.is_part_of_discussion?(@discussion)
        format.html{ redirect_to current_user, notice: "Du bist nicht für diese Discussion eingetragen" }
        format.json{ render status: :forbidden }
      else
        current_user.enter_discussion(@discussion)
        PrivatePub.publish_to "/discussion/"+@discussion.id.to_s+"/users/enter", user_id: current_user.id

        format.html{ @questions = Question.where(discussion_id: params[:id]) }
        format.json do

          if current_user == @discussion.moderator
            @arguments = @discussion.arguments
            @votes = Vote.where('argument_id in (:arguments)', {arguments: @discussion.arguments})

          else
            @arguments = []
            discussion_user = DiscussionsUser.where(discussion_id: @discussion.id, user_id: current_user).first()
            @discussion.arguments.each do | argument |
              if argument.argument_type.name == 'proband' or argument.argument_type.name == 'moderator' or discussion_user.role.name == 'observer'
                @arguments.push(argument)
              end
            end
            @votes = Vote.where('argument_id in (:arguments) and user_id = :user', {arguments: @discussion.arguments, user: current_user})
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
    @proband_role =  Role.where(name: 'proband').first()
    @observer_role =  Role.where(name: 'observer').first()
    @probands = DiscussionsUser.where(discussion_id: @discussion.id, role_id: @proband_role.id)
    @observers = DiscussionsUser.where(discussion_id: @discussion.id, role_id: @observer_role.id)
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @proband = DiscussionsUser.new
    @visual_aid = VisualAid.new
    @users = User.all

  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.users << current_user
    @discussion.discussions_users.first().role = Role.where(name: 'moderator').first()
    @question = Question.create(topic: "Herzlich Willkommen", discussion: @discussion)

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
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  # GET /discussions/1/evaluate
  def evaluate
  end

  def arguments
    respond_to do | format |
      format.json{ render json: @discussion.arguments }
      format.html{ render json: @discussion.arguments }
    end
  end

  def add_visual_aid

  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:topic, :moderator, :due_date, :moderator_id, :users, :company_id, :company, :visual_aids)
    end

end
