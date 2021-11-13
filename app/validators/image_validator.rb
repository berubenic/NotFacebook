# frozen_string_literal: true

class ImageValidator < ActiveModel::Validator
  def validate(record)
    attribute = options[:fields][:attribute_name]
    return unless record.public_send(attribute).attached?

    record.errors.add(attribute, 'is too big') unless record.public_send(attribute).byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']

    return if acceptable_types.include?(record.public_send(attribute).content_type)

    record.errors.add(attribute, 'must be a JPEG or PNG')
  end
end
