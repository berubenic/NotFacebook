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
