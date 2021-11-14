# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  has_many :notifications, dependent: :delete_all

  after_create :create_notification

  private

  def create_notification
    if post_id
      post = Post.find(post_id)
      user = post.user
      Notification.create(user_id: user.id, like_id: id)
    end
  end
end
