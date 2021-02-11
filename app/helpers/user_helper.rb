module UserHelper
  def resource_name
    :user
  end

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
