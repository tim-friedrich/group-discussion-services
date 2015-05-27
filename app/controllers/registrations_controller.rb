class RegistrationsController < Devise::RegistrationsController
  def create
    
    sign_out
    reset_session
    
    super do | resource |
      if resource.role == Role.admin
        forbidden
      end
    end
    flash.delete(:notice)
    rescue
  end


  protected

  def after_sign_up_path_for(resource)
    if resource.is_proband?
      '/survey'
    elsif resource.is_customer?
      '/discussions/new'
    else
      '/profile'
    end
  end
end