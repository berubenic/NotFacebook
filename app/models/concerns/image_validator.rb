module ImageValidator
  extend ActiveSupport::Concern

  def acceptable_image
    return unless profile_image.attached?

    errors.add(:profile_image, 'is too big') unless profile_image.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']

    errors.add(:profile_image, 'must be a JPEG or PNG') unless acceptable_types.include?(profile_image.content_type)
  end
end
