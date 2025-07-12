class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:default_avatar,:profile_picture])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:default_avatar, :profile_picture])
  end

  def after_sign_in_path_for(_resource)
    my_dashboard_path # or authenticated_root_path
  end

  # ✅ Redirect users after logout
  def after_sign_out_path_for(_resource_or_scope)
    unauthenticated_root_path
  end
end
