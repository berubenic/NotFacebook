# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { in: 2..20 }
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
                                               message: 'only allows letters' }
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :likes, dependent: :destroy

  has_one_attached :profile_image
  validates_with ImageValidator, fields: { attribute_name: :profile_image }

  def friends
    sent_friendships = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    recieved_friendships = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = sent_friendships + recieved_friendships
    User.where(id: ids)
  end

  def friend_with?(user)
    Friendship.confirmed?(id, user.id)
  end

  def pending_friend_requests_sent
    pending_friends_ids = Friendship.where(user_id: id, confirmed: false).pluck(:friend_id)
    User.where(id: pending_friends_ids)
  end

  def pending_friend_requests_recieved
    pending_friends_ids = Friendship.where(friend_id: id, confirmed: false).pluck(:user_id)
    User.where(id: pending_friends_ids)
  end

  def likes_post?(post)
    return true if Like.find_by(user_id: id, post_id: post.id)

    false
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[-1]
    end
  end

  def full_name
    first_name + ' ' + last_name
  end
end
