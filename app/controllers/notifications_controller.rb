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

  def update
    case params[:type]
    when 'friend'
      update_friend_notification(params)
    when 'like'
      update_like_notification(params)
    when 'comment'
      update_comment_notification(params)
    end
  end

  def mark_all_as_seen
    notifications = current_user.notifications
    notifications.each do |notification|
      notification.seen = true
      notification.save
    end
    redirect_to notifications_path
  end

  def delete_all_notifications
    notifications = current_user.notifications
    notifications.each do |notification|
      notification.destroy!
    end
    flash[:alert] = 'All notifications have been deleted.'
    redirect_to notifications_path
  end

  private

  def update_comment_notification(params)
    comment = Comment.find(params[:id])
    notification = Notification.find_by(user_id: current_user.id, comment_id: comment.id)
    notification.seen = true
    notification.save!

    redirect_to comment.post
  end

  def update_like_notification(params)
    like = Like.find(params[:id])
    if like.post
      update_post_like_notification(like)
    elsif like.comment
      update_comment_like_notification(like)
    end
  end

  def update_post_like_notification(like)
    post = Post.find(like.post.id)
    notification = Notification.find_by(user_id: current_user.id, like_id: like.id)
    notification.seen = true
    notification.save!
    redirect_to post
  end

  def update_comment_like_notification(like)
    comment = Comment.find(like.comment.id)
    post = comment.post
    notification = Notification.find_by(user_id: current_user.id, like_id: like.id)
    notification.seen = true
    notification.save!
    redirect_to post
  end

  def update_friend_notification(params)
    friend = User.find(params[:id])
    friendship = Friendship.find_by(user_id: friend.id, friend_id: current_user.id)
    notification = Notification.find_by(user_id: current_user.id, friendship_id: friendship.id)
    notification.seen = true
    notification.save!

    redirect_to users_path
  end

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
