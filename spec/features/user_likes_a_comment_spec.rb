require 'rails_helper'

RSpec.feature 'User likes a comment' do
  context 'user is on the home page' do
    scenario 'they like a  comment' do
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

      expect(page).to have_content 'Unlike (1 Like)'
    end
  end
end
