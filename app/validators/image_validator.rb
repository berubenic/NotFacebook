# frozen_string_literal: true

class ImageValidator < ActiveModel::Validator
  def validate(record)
    attribute = options[:fields][:attribute_name]
    return unless record.public_send(attribute).attached?

    unless record.public_send(attribute).byte_size <= 1.megabyte
      record.errors.add(attribute, 'is too big')
    end

    acceptable_types = %w[image/jpeg image/png]

    if acceptable_types.include?(record.public_send(attribute).content_type)
      return
    end

    record.errors.add(attribute, 'must be a JPEG or PNG')
  end
end
