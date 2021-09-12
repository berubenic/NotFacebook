require 'rails_helper'

RSpec.describe Friendship, type: :model do
  fixtures :friendships, :users
  describe '#self.confirmed?' do
    it 'returns false when not friends' do
      u1 = users(:user_one)
      u3 = users(:user_three)
      confirmed = Friendship.confirmed?(u1.id, u3.id)
      expect(confirmed).to be false
    end

    it 'returns true when friends' do
      u1 = users(:user_one)
      u5 = users(:user_five)
      confirmed = Friendship.confirmed?(u1.id, u5.id)
      expect(confirmed).to be true
    end
  end

  describe '#self.already_sent?' do
    it 'returns true if sent' do
      u1 = users(:user_one)
      u3 = users(:user_three)
      sent = Friendship.already_sent?(u1.id, u3.id)
      expect(sent).to be true
    end

    it 'returns false if not sent' do
      u1 = users(:user_one)
      u2 = users(:user_two)
      sent = Friendship.already_sent?(u1.id, u2.id)
      expect(sent).to be false
    end
  end

  describe '#self.pending_accept?' do
    it 'returns true if user has received a request' do
      u1 = users(:user_one)
      u4 = users(:user_four)
      pending = Friendship.pending_accept?(u1.id, u4.id)
      expect(pending).to be true
    end

    it 'returns false if user has not received a request' do
      u1 = users(:user_one)
      u2 = users(:user_two)
      pending = Friendship.pending_accept?(u1.id, u2.id)
      expect(pending).to be false
    end
  end
end
