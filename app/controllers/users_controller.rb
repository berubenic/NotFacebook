class UsersController < ApplicationController
  def index
    user = current_user
    @friends_sent = user.pending_friend_requests_sent
    @friends_recieved = user.pending_friend_requests_recieved
    @strangers = User.all
  end

  def delete_profile_image
    current_user.profile_image.purge
    redirect_to edit_user_registration_path
  end
end
