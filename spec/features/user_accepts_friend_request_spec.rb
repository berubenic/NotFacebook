require 'rails_helper'

RSpec.feature 'user accepts friend request' do
  context 'they have no friends' do
    scenario 'they accept a friend request' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Accept Request'

      expect(page).to have_content(friend_one.full_name)
    end
  end
end
