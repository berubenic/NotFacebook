# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :friendship, dependent: :destroy, optional: true
  belongs_to :like, dependent: :destroy, optional: true

  scope :unseen, -> { where(seen: false) }
end
