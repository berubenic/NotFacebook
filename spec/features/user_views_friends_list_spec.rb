require 'rails_helper'

RSpec.feature 'User views friends list' do
  context 'they have no friends' do
    scenario 'they see the page with the list of friends' do
      user = create(:user)
      create(:user, first_name: 'friend', last_name: 'one')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      expect(page).to have_content('friend one').once
    end
  end

  context 'they have no friend' do
    scenario 'they add a friend' do
      user = create(:user)
      create(:user, first_name: 'friend', last_name: 'one')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      expect(User.count).to eq 2

      click_on 'Add Friend'

      expect(user.pending_friend_requests_sent.count).to eq 1
    end
  end

  context ' they have no friend' do
    scenario 'they recieve a friend request' do
      user = create(:user)
      friend = create(:user, first_name: 'friend', last_name: 'one')

      create(:friendship, user: friend, friend: user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      expect(user.pending_friend_requests_recieved.count).to eq 1
    end
  end
end
