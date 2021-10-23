class UsersController < ApplicationController
  def index
    user = current_user
    @friends = user.friends
    friends_ids = @friends.pluck(:id)

    @friends_sent = user.pending_friend_requests_sent
    friends_sent_ids = @friends_sent.pluck(:id)

    @friends_recieved = user.pending_friend_requests_recieved
    friends_recieved_ids = @friends_recieved.pluck(:id)

    ids = friends_ids + friends_sent_ids + friends_recieved_ids + [current_user.id]
    @strangers = User.where.not(id: ids)
  end

  def delete_profile_image
    current_user.profile_image.purge
    redirect_to edit_user_registration_path
  end
end
