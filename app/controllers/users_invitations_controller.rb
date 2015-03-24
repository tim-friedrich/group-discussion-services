class UsersInvitationsController < Devise::InvitationsController
  def update
    super
    for discussions_user in User.find_by_email(invite_params[:email]).discussions_users do
      discussions_user.set_name
    end
  end

  def invite_resource
  end

  def edit
  end

  def create
    user = User.invite!({ email: invite_params[:email] }, current_inviter)

    respond_to do |format|
      format.js do
        if invite_params['discussion_id']
          if current_user.is_deputy?
            user.research_institutes << current_user.deputy_institute
          end
          @discussion = Discussion.find(invite_params[:discussion_id])
          @discussion.users << user
          @discussions_user = @discussion.discussions_users.last
          @discussions_user.role = Role.find_by_name(invite_params[:discussions_user_role])
          @proband_role =  Role.find_by_name('proband')
          @observer_role =  Role.find_by_name('observer')
          @probands = DiscussionsUser.where(discussion: @discussions_user.discussion, role: @proband_role).paginate(:page => params[:probands_page], :per_page => 10)
          @observers = DiscussionsUser.where(discussion: @discussions_user.discussion, role: @observer_role).paginate(:page => params[:observers_page], :per_page => 10)

          render 'discussions_users/update_lists'
        else
          render nothing: true
        end

      end
      format.html{ }
    end
  end
end