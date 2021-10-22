require 'rails_helper'

RSpec.feature 'User sees sent requests from friend list' do
  context 'they have no friends' do
    scenario 'they can add a friend' do
      user = create(:user)
      create(:user, first_name: 'friend', last_name: 'one')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Add Friend'

      expect(page).to have_content('Friend request sent sucessfully')
    end

    scenario 'they see the requests sent' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Add Friend'

      expect(page).to have_content(friend_one.full_name)
    end
  end

  context 'they have one friend' do
    scenario 'they can not send a request when already sent' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: user, friend: friend_one, confirmed: true)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      expect(page).to_not have_selector(:link_or_button, 'Add Friend')
    end

    scenario 'they can see who their friends with' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: user, friend: friend_one, confirmed: true)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      expect(page).to have_content(friend_one.full_name)
    end
  end
end
