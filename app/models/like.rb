# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  has_many :notifications, dependent: :delete_all
  enum category: {
    'post' => 0,
    'comment' => 1
  }

  after_create :create_notification

  private

  def create_notification
    case category
    when 'post'
      post = Post.find(post_id)
      user = post.user
      Notification.create!(user_id: user.id, like_id: id)
    when 'comment'
      comment = Comment.find(comment_id)
      user = comment.user
      Notification.create!(user_id: user.id, like_id: id)
    end
  end
end
