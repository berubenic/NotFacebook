require 'rails_helper'

RSpec.feature 'user accepts friend request' do
  context 'they have no friends' do
    scenario 'they decline a friend request' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Decline Request'

      expect(page).to have_content('Friend Request Declined!')
    end
  end
end
