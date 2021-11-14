# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :friendship, dependent: :destroy

  scope :unseen, -> { where(seen: false) }
end
