# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(body: 'Some cool stuff goes here')
  end
  describe '#body' do
    it 'validates_presence' do
      subject.body = ''
      subject.validate
      expect(subject.errors[:body]).to include("can't be blank")

      subject.body = 'Some cool stuff goes here'
      subject.validate
      expect(subject.errors[:body]).to_not include("can't be blank")
    end

    it 'validates_length' do
      subject.body = '1'
      subject.validate
      expect(subject.errors[:body]).to include('is too short (minimum is 5 characters)')

      subject.body = '12345'
      subject.validate
      expect(subject.errors[:body]).to_not include('is too short (minimum is 5 characters)')
    end
  end
end
