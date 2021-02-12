class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Configure extra permitted parameters as the Devise User model has added fields
  def configure_permitted_parameters
    added_attrs = [:username, :avatar, :email, :password, :password_confirmation, :remember_me, :bio, :location]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
