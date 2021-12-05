# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, touch: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 1000 }

  has_one_attached :post_image
  validates_with ImageValidator, fields: { attribute_name: :post_image }

  def acceptable_image
    return unless post_image.attached?

    unless post_image.byte_size <= 1.megabyte
      errors.add(:post_image, 'is too big')
    end

    acceptable_types = %w[image/jpeg image/png]

    unless acceptable_types.include?(post_image.content_type)
      errors.add(:post_image, 'must be a JPEG or PNG')
    end
  end
end
