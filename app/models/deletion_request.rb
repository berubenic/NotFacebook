# frozen_string_literal: true

class DeletionRequest < ApplicationRecord
  validates :uid, :provider, :pid, presence: true

  # there can only be one entry with given provider + uid
  validates :uid, uniqueness: { scope: :provider }

  before_validation :set_pid

  def run
    u = User.where(provider: provider, uid: uid).first
    u.destroy! if u.present?
  end

  def deleted?
    User.where(provider: provider, uid: uid).count.zero?
  end

  # ============
  # UTIL
  # ============

  def self.from_signed_fb(req)
    data = DeletionRequest.parse_fb_request(req)
    DeletionRequest.create(provider: 'facebook', uid: data['user_id'])
  end

  def self.parse_fb_request(req)
    encoded, payload = req.split('.', 2)
    decoded = Base64.urlsafe_decode64(encoded)
    data = JSON.parse(Base64.urlsafe_decode64(payload))

    # we need to verify the digest is the same
    exp = OpenSSL::HMAC.digest('SHA256', ENV['FACEBOOK_APP_SECRET'], payload)

    if decoded != exp
      Rails.logger.debug 'FB deletion callback called with weird data'
      return nil
    end

    data
  end

  private

  def set_pid
    self.pid = random_pid if pid.blank?
  end

  def random_pid
    SecureRandom.hex(4)
  end
end
