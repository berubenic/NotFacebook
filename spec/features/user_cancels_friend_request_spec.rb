require 'rails_helper'

RSpec.feature 'User cancels friend request' do
  context 'The user is on the home page' do
    scenario 'they cancel a friend request' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: user, friend: friend_one, confirmed: false)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Cancel Request'

      expect(page).to_not have_content 'Cancel Request'
    end
  end
end
