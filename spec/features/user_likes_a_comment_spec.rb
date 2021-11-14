require 'rails_helper'

RSpec.feature 'User likes a comment' do
  context 'user is on the home page' do
    scenario 'they like their own comment' do
      user = create(:user)
      post = create(:post, user: user)
      create(:comment, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      within('div', class: 'comment-container') do
        click_on 'Like'
      end

      expect(page).to have_content('Unlike (1 Like)', count: 1)
    end

    scenario 'they like their friends comment' do
      user = create(:user)
      friend = create(:user, first_name: 'friend', last_name: 'one')
      post = create(:post, user: user)
      create(:comment, user: friend, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      within('div', class: 'comment-container') do
        click_on 'Like'
      end

      expect(page).to have_content 'Unlike (1 Like)', count: 1
    end
  end
end
