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
end
