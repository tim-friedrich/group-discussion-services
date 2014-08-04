class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
 	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	before_filter :configure_permitted_parameters, if: :devise_controller?
  	before_action :set_locale

  	protected

 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) << :lastname
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
