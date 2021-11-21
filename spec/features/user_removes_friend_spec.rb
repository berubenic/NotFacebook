require 'rails_helper'

RSpec.feature 'User removes friend' do
  context 'they are on the home page' do
    scenario 'they have one friend' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: true)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Friends'

      click_on 'Remove Friend'

      expect(page).to have_content('Friend Removed!')
      expect(user.friends.count).to eq 0
    end
  end
end
