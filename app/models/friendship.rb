class Friendship < ApplicationRecord
  belongs_to :user

  def self.confirmed?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.already_sent?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end
end
