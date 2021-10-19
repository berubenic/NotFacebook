require 'rails_helper'

RSpec.feature "User sees friends' post on feed" do
  context 'they have friends who posted' do
    scenario "they are on their feed's page" do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friend_two = create(:user, first_name: 'friend', last_name: 'two')
      create(:friendship, user: user, friend: friend_one)
      create(:friendship, user: user, friend: friend_two)
      create(:post, user: friend_one)
      create(:post, user: friend_two)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('I am a body').twice
    end
  end

  context 'they have no friends who posted' do
    scenario "they are on their feed's page" do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friend_two = create(:user, first_name: 'friend', last_name: 'two')
      create(:friendship, user: user, friend: friend_one)
      create(:friendship, user: user, friend: friend_two)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to_not have_content('I am a body')
    end
  end
end
