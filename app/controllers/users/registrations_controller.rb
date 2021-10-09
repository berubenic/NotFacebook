class Users::RegistrationsController < Devise::RegistrationsController
  def after_update_path_for(_resource)
    flash[:notice] = 'Account succesfully updated'
    edit_user_registration_path
  end

  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    if current_user.provider == 'facebook'
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
