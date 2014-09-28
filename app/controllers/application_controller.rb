class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for resource_or_scope
    root_path
  end

private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        << []
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :post_code]
  end
end