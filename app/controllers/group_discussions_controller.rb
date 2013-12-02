class GroupDiscussionsController < ApplicationController
  before_action :set_group_discussion, only: [:show, :edit, :update, :destroy]

  # GET /group_discussions
  # GET /group_discussions.json
  def index
    @group_discussions = GroupDiscussion.all
  end

  # GET /group_discussions/1
  # GET /group_discussions/1.json
  def show
  end

  # GET /group_discussions/new
  def new
    @group_discussion = GroupDiscussion.new
  end

  # GET /group_discussions/1/edit
  def edit
  end

  # POST /group_discussions
  # POST /group_discussions.json
  def create
    @group_discussion = GroupDiscussion.new(group_discussion_params)

    respond_to do |format|
      if @group_discussion.save
        format.html { redirect_to @group_discussion, notice: 'Group discussion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_discussion }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_discussions/1
  # PATCH/PUT /group_discussions/1.json
  def update
    respond_to do |format|
      if @group_discussion.update(group_discussion_params)
        format.html { redirect_to @group_discussion, notice: 'Group discussion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_discussions/1
  # DELETE /group_discussions/1.json
  def destroy
    @group_discussion.destroy
    respond_to do |format|
      format.html { redirect_to group_discussions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_discussion
      @group_discussion = GroupDiscussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_discussion_params
      params.require(:group_discussion).permit(:name, :description, :appointment)
    end
end
