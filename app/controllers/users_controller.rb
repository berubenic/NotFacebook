class UsersController < ApplicationController
  def delete_profile_image
    current_user.profile_image.purge
    redirect_to edit_user_registration_path
  end
end
