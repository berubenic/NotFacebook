# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
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
  end
end
