require 'rails_helper'

RSpec.describe Friendship, '.confirmed?' do
  it 'returns true if friendship has been accepted' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: user, friend: friend, confirmed: true)
    expect(Friendship.confirmed?(user.id, friend.id)).to eq true
  end

  it 'returns false if friendship has not been accepted' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: user, friend: friend, confirmed: false)
    expect(Friendship.confirmed?(user.id, friend.id)).to eq false
  end
end

RSpec.describe Friendship, '.already_sent?' do
  it 'returns true if friendship request has already been sent' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    sent_friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: user, friend: sent_friend, confirmed: false)
    expect(Friendship.already_sent?(user.id, sent_friend.id)).to eq true
  end

  it 'returns false if friendship has not been sent' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    stranger = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    expect(Friendship.already_sent?(user.id, stranger.id)).to eq false
  end
end

RSpec.describe Friendship, '.pending_accept?' do
  it 'returns true if user has a pending friendship request with given user' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    pending_friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: pending_friend, friend: user, confirmed: false)
    expect(Friendship.pending_accept?(user.id, pending_friend.id)).to eq true
  end

  it 'returns false if user does not have a pending friendship request with given user' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    stranger = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    expect(Friendship.pending_accept?(user.id, stranger.id)).to eq false
  end
end
