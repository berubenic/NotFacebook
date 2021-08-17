# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(first_name: 'Homer',
                        last_name: 'Simpson')
  end
  describe '#first_name' do
    it 'validates_presence' do
      subject.first_name = ''
      subject.validate
      expect(subject.errors[:first_name]).to include("can't be blank")

      subject.first_name = 'Homer'
      subject.validate
      expect(subject.errors[:first_name]).to_not include("can't be blank")
    end

    it 'validates_length' do
      subject.first_name = 'H'
      subject.validate
      expect(subject.errors[:first_name]).to include('is too short (minimum is 2 characters)')

      subject.first_name = 'Homer'
      subject.validate
      expect(subject.errors[:first_name]).to_not include('is too short (minimum is 2 characters)')

      subject.first_name = 'Hooooooooooooooooomer'
      subject.validate
      expect(subject.errors[:first_name]).to include('is too long (maximum is 20 characters)')

      subject.first_name = 'Homer'
      subject.validate
      expect(subject.errors[:first_name]).to_not include('is too long (maximum is 20 characters)')
    end

    it 'validates_format' do
      subject.first_name = '1'
      subject.validate
      expect(subject.errors[:first_name]).to include('only allows letters')

      subject.first_name = '!'
      subject.validate
      expect(subject.errors[:first_name]).to include('only allows letters')

      subject.first_name = 'Homer'
      subject.validate
      expect(subject.errors[:first_name]).to_not include('only allows letters')
    end
  end

  describe '#last_name' do
    it 'validates_presence' do
      subject.last_name = ''
      subject.validate
      expect(subject.errors[:last_name]).to include("can't be blank")

      subject.last_name = 'Simpson'
      subject.validate
      expect(subject.errors[:last_name]).to_not include("can't be blank")
    end

    it 'validates_length' do
      subject.last_name = 'S'
      subject.validate
      expect(subject.errors[:last_name]).to include('is too short (minimum is 2 characters)')

      subject.last_name = 'Simpson'
      subject.validate
      expect(subject.errors[:last_name]).to_not include('is too short (minimum is 2 characters)')

      subject.last_name = 'Siiiiiiiiiiiiiiimpson'
      subject.validate
      expect(subject.errors[:last_name]).to include('is too long (maximum is 20 characters)')

      subject.last_name = 'Simpson'
      subject.validate
      expect(subject.errors[:last_name]).to_not include('is too long (maximum is 20 characters)')
    end
  end
end
