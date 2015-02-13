class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  check_authorization :unless => :devise_controller?


  rescue_from CanCan::AccessDenied do |exception|
    if current_user && current_user.is_proband? && !current_user.has_survey?
      redirect_to survey_path, :alert => exception.message
    else
      redirect_to root_path, :alert => exception.message
    end
  end


  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:firstname, :lastname, :username, :discussion_id]
    devise_parameter_sanitizer.for(:invite).concat [:email, :discussion_id, :discussions_user_role]
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) << :lastname
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def after_sign_in_path_for(resource)
    '/profile'
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
