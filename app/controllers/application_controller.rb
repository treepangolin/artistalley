class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :secondary

  include PublicActivity::StoreController

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.js { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to user_signed_in? ? user_root_path : welcome_root_path, alert: exception.message }
    end
  end

  protected

  # Configure extra permitted parameters as the Devise User model has added fields
  def configure_permitted_parameters
    added_attrs = %i[username avatar email password password_confirmation remember_me bio pronouns location invite_code]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
