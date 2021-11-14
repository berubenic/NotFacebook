# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id)
    @friends = find_friends_from_friendships(@notifications)
    mark_notifications_as_seen(@notifications)
  end

  def create
    Notification.create!(user_id: params[:user_id], friendship_id: params[:friendship_id])
    redirect_to users_path
  end

  private

  def find_friends_from_friendships(notifications, friends = [])
    notifications.each do |notification|
      friendship = notification.friendship
      friends << friendship.user
    end
    friends
  end

  def mark_notifications_as_seen(notifications)
    notifications.each do |notification|
      notification.seen = true
      notification.save
    end
  end
end
