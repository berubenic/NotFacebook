require 'rails_helper'

RSpec.feature 'user sees notifications' do
  context 'they recieve a friend request' do
    scenario 'they are on the home page' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('Notifications (1)')
    end

    scenario 'they view their notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      expect(page).to have_content 'friend one sent you a friend request.'
      expect(page).to have_content 'Notifications (0)'
    end
  end

  context 'they recieve a like on a post' do
  end

  context 'they recieve a like on a comment' do
  end

  context 'they recieve a comment on a post' do
  end
end
