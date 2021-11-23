# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :friendship, optional: true
  belongs_to :like, optional: true
  belongs_to :comment, optional: true

  scope :unseen, -> { where(seen: false) }
end
