# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, dependent: :delete_all

  after_create :create_notification

  def self.confirmed?(id1, id2)
    case1 =
      !Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 =
      !Friendship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.already_sent?(id1, id2)
    !Friendship.where(user_id: id1, friend_id: id2).empty?
  end

  def self.pending_accept?(id1, id2)
    !Friendship.where(user_id: id2, friend_id: id1).empty?
  end

  private

  def create_notification
    Notification.create!(user_id: friend.id, friendship_id: id)
  end
end
