require 'rails_helper'

RSpec.describe User, '#full_name' do
  it 'returns first_name and last_name' do
    user = User.new(first_name: 'Joe', last_name: 'Picket')
    expect(user.full_name).to eq 'Joe Picket'
  end
end

RSpec.describe User, '#friend_with?' do
  it 'returns true if friends with passed user' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    possible_friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: user, friend: possible_friend, confirmed: true)
    expect(user.friend_with?(possible_friend)).to eq true
  end
end
