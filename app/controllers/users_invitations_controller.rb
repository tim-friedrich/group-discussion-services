class UsersInvitationsController < Devise::InvitationsController
  def invite_resource

  end

  def edit

  end
  def create
    user = User.invite!({ email: invite_params[:email] }, current_inviter)
    puts user.to_yaml
    respond_to do |format|
      # puts "A>"*100
      format.js do
        if invite_params['discussion_id']
          # puts "A"*100
          puts params['discussion_id']
          #  puts user.to_yaml
          @discussion = Discussion.find(invite_params[:discussion_id])
          @discussion.users << user
          @discussions_user = @discussion.discussions_users.last()
          @discussions_user.role = Role.where(name: invite_params[:discussions_user_role]).first()
          puts @discussions_user.to_yaml
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