# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 1000 }
end
