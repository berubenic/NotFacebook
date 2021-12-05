# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    Friendship.create!(user_id: current_user.id, friend_id: params[:friend_id])
    flash[:notice] = 'Friend request sent sucessfully!'
    redirect_to users_path
  end

  def update
    friendship =
      Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship.update(confirmed: true)
    flash[:notice] = 'Friend Request Accepted!'
    redirect_to users_path
  end

  def destroy
    friendship =
      Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship ||=
      Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    flash[:notice] =
      friendship.confirmed ? 'Friend Removed!' : 'Friend Request Declined!'
    begin
      friendship.destroy!
    rescue ActiveRecord::RecordNotDestroyed => e
      p e.record.errors
    end
    redirect_to users_path
  end

  def cancel_friendship
    friendship =
      Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship ||=
      Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    flash[:notice] = 'Friend Request Canceled!'
    friendship.destroy
    redirect_to users_path
  end
end
