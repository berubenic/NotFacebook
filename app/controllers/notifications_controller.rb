# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id)
    @friends = find_friends_from_notifications(@notifications)
    @post_likes = find_post_likes_from_notifications(@notifications)
    @comment_likes = find_comment_likes_from_notifications(@notifications)
    @comments = find_comments_from_notifications(@notifications)
  end

  def create
    Notification.create!(user_id: params[:user_id], friendship_id: params[:friendship_id])
    redirect_to users_path
  end

  private

  def find_comments_from_notifications(notifications, comments = [])
    notifications.each do |notification|
      comment = notification.comment
      next unless comment

      comments << comment
    end
    comments
  end

  def find_comment_likes_from_notifications(notifications, likes = [])
    notifications.each do |notification|
      like = notification.like
      next unless like

      likes << like if like.comment_id
    end
    likes
  end

  def find_post_likes_from_notifications(notifications, likes = [])
    notifications.each do |notification|
      like = notification.like
      next unless like

      likes << like if like.post_id
    end
    likes
  end

  def find_friends_from_notifications(notifications, friends = [])
    notifications.each do |notification|
      next unless notification.friendship

      friendship = notification.friendship
      friends << friendship.user
    end
    friends
  end
end
