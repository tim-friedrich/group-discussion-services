class RegistrationsController < Devise::RegistrationsController
  def create
    sign_out
    reset_session
    super
    flash.delete(:notice)
  end


  protected

  def after_sign_up_path_for(resource)
    if resource.is_proband?
      '/survey'
    else
      '/profile'
    end
  end
end