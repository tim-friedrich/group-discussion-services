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
            user.research_institutes << current_user.deputy_institute()
          end
          @discussion = Discussion.find(invite_params[:discussion_id])
          @discussion.users << user
          @discussions_user = @discussion.discussions_users.last()
          @discussions_user.role = Role.where(name: invite_params[:discussions_user_role]).first()
          @proband_role =  Role.where(name: 'proband').first()
          @observer_role =  Role.where(name: 'observer').first()
          @probands = DiscussionsUser.where(discussion_id: @discussions_user.discussion.id, role_id: @proband_role.id).paginate(:page => params[:probands_page], :per_page => 10)
          @observers = DiscussionsUser.where(discussion_id: @discussions_user.discussion.id, role_id: @observer_role.id).paginate(:page => params[:observers_page], :per_page => 10)

          render 'discussions_users/update_lists'
        else
          render nothing: true
        end

      end
      format.html{ }
    end
  end
end