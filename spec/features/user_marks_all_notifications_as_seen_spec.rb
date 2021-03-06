require 'rails_helper'

RSpec.feature 'user marks all notifications as seen' do
  context 'they are on the home page' do
    scenario 'they mark all notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friend_two = create(:user, first_name: 'friend', last_name: 'two')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      create(:friendship, user: friend_two, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications (2)'

      click_on 'Mark All as Seen'

      expect(page).to have_content 'Notifications (0)'
    end
  end
end
