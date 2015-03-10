class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  if (!:devise_controller? || !:rails_admin_controller?)
    check_authorization
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to '/404.html' # TODO use Rails4 error app
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user && current_user.survey_required? && !current_user.has_survey?
      redirect_to survey_path, :alert => "Sie müssen erst den Persönlichkeitstest ausfüllen um fortzufahren zu können!"
    else
      redirect_to main_app.root_path, :alert => exception.message
    end
  end

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to root_path, :alert => "Ihre Session ist abgelaufen, bitte probieren Sie es noch einmal!"
  end

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to root_path, :alert => "Ihre Session ist abgelaufen, bitte probieren Sie es noch einmal!"
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat SETTINGS[:good_user_params]
    devise_parameter_sanitizer.for(:invite).concat [:email, :discussion_id, :discussions_user_role]
    devise_parameter_sanitizer.for(:sign_up).concat SETTINGS[:good_user_params]
  end

  def after_sign_in_path_for(resource)
    '/profile'
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
