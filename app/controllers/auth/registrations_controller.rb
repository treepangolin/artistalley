# frozen_string_literal: true

class Auth::RegistrationsController < Devise::RegistrationsController
  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?

    respond_to do |format|
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        format.html { respond_with resource, location: after_update_path_for(resource) }
      else
        clean_up_passwords resource
        set_minimum_password_length

        format.turbo_stream
        format.html { respond_with resource }
      end
    end
  end

  protected

  def update_resource(resource, params)
    # Only require current password if user wants to change it
    return super if params['password']&.present?

    # Otherwise, allow minor account changes without password
    resource.update_without_password(params.except('current_password'))
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
