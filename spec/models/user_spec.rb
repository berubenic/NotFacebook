require 'rails_helper'

RSpec.describe User, 'validations' do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  # length
  it { is_expected.to validate_length_of(:first_name) }
  it { is_expected.to allow_value('Jo').for(:first_name) }
  it { is_expected.to_not allow_value('J').for(:first_name) }
  it { is_expected.to validate_length_of(:last_name) }
  it { is_expected.to allow_value('Jo').for(:last_name) }
  it { is_expected.to_not allow_value('J').for(:last_name) }
  # format
  it { is_expected.to_not allow_value('12').for(:first_name) }
  it { is_expected.to_not allow_value('1Jo').for(:first_name) }
  it { is_expected.to_not allow_value('12').for(:last_name) }
  it { is_expected.to_not allow_value('1Jo').for(:last_name) }
end

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

  it 'returns false if not friends with passed user' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    possible_friend = create(:user, first_name: 'Jack', last_name: 'Sparrow')
    create(:friendship, user: user, friend: possible_friend, confirmed: false)
    expect(user.friend_with?(possible_friend)).to eq false
  end
end

RSpec.describe User, '#friends' do
  it 'returns a collection of friends' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    friend_one = create(:user, first_name: 'Jack')
    friend_two = create(:user, first_name: 'Alice')
    stranger_one = create(:user, first_name: 'Stranger')

    create(:friendship, user: user, friend: friend_one, confirmed: true)
    create(:friendship, user: friend_two, friend: user, confirmed: true)
    create(:friendship, user: user, friend: stranger_one, confirmed: false)

    result = user.friends

    expect(result).to eq [friend_one, friend_two]
    expect(result).not_to include(stranger_one)
  end
end

RSpec.describe User, '#acceptable_image' do
  it 'adds errors if image is too big' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    user.profile_image.attach(io: File.open(Rails.root + 'spec/fixtures/too_big.png'), filename: 'too_big.png')

    expect(user.errors.full_messages).to include('Profile image is too big')
  end

  it 'adds errors if image is wrong type' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    user.profile_image.attach(io: File.open(Rails.root + 'spec/fixtures/wrong_type.fig'), filename: 'wrong_type.fig')
    puts user.profile_image.content_type

    expect(user.errors.full_messages).to include('Profile image must be a JPEG or PNG')
  end
end

RSpec.describe User, '.from_omniauth' do
  let(:auth_hash) do
    OmniAuth::AuthHash.new({
                             provider: 'facebook',
                             uid: '1234',
                             info: {
                               email: 'email@email.com',
                               name: 'Joe Picket'
                             }
                           })
  end
  it 'retrieves an existing user' do
    user = User.new(
      provider: 'facebook',
      uid: '1234',
      email: 'email@email.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Joe',
      last_name: 'Picket'
    )
    user.save

    omniauth_user = User.from_omniauth(auth_hash)

    expect(user).to eq(omniauth_user)
  end

  it 'creates a new user if one does not exist' do
    expect(User.count).to eq(0)

    User.from_omniauth(auth_hash)

    expect(User.count).to eq(1)
  end
end
