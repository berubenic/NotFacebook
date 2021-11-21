# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :delete_all

  validates :body, presence: true

  after_create :create_notification

  private

  def create_notification
    post = Post.find(post_id)
    user = post.user
    Notification.create!(user_id: user.id, comment_id: id)
  end
end
