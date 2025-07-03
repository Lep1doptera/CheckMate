class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:default_avatar,:profile_picture])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:default_avatar, :profile_picture])
  end
end
