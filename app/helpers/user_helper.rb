module UserHelper
  # Methods here allow user to edit their own fields on non-Devise templates

  def resource_name
    :user
  end

  # Set resource global to current_user for Devise forms
  def resource
    @resource ||= current_user if user_signed_in?
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
