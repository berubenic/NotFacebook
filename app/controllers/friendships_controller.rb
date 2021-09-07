class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    if Friendship.already_sent?(params[:user_id], params[:friend_id])
      flash[:notice] = 'You have already sent a friendship request to this user'
      return redirect_to friends_path
    elsif Friendship.pending_accept?(params[:user_id], params[:friend_id])
      flash[:notice] = 'A friend request has already been sent to you'
      return redirect_to friends_path
    end
    Friendship.create!(user_id: params[:user_id], friend_id: params[:friend_id])
    flash[:success] = 'Friend added!'
    redirect_to friends_path
  end

  def update
    friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship.update(confirmed: true)
    flash[:notice] = 'Friend Request Accepted!'
    redirect_to root_url
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship.destroy
    flash[:notice] = 'Friend Request Declined!'
    redirect_to root_url
  end
end
