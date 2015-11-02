class UsersInvitationsController < Devise::InvitationsController

  def update
    super
    for discussions_user in User.find_by_email(invite_params[:email]).discussions_users do
      discussions_user.set_name
    end
  end

  def invite_resource
    if cannot?( :invite, User )
      raise CanCan::AccessDenied
    else
      super
    end
  end

  def new
    if cannot?( :invite, User )
      raise CanCan::AccessDenied
    else
      super
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      format.js{
        if current_user.role == Role.extModerator
          user = User.invite!({ email: invite_params[:email], shared_pool: false }, current_inviter)
        else
          user = User.invite!({ email: invite_params[:email] }, current_inviter)
        end
        if invite_params['discussion_id']
          @discussion = Discussion.find(invite_params[:discussion_id])
          @discussions_user = @discussion.discussions_users.create(
            user: user,
            role: Role.find_by_name(invite_params[:discussions_user_role]),
          )

          @probands  = @discussion.probands.paginate(page: params[:probands_page], per_page: 10)
          @observers = @discussion.observers.paginate(page: params[:observers_page], per_page: 10)

          render 'discussions_users/update_lists'
        end
      }
      format.html{
        if cannot?( :invite, User )
          raise CanCan::AccessDenied
        else
          user = User.invite!({ email: invite_params[:email], role: Role.find_by_id(invite_params[:role_id]) }, current_inviter)
          redirect_to '/users/invitation/new'
        end
      }
    end
  end

  private

  def after_accept_path_for(resource)
    survey_path
  end
end