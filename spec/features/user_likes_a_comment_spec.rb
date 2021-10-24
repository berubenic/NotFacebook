require 'rails_helper'

RSpec.feature 'User likes a comment' do
  context 'user is on the home page' do
    scenario 'they unlike a  comment' do
      user = create(:user)
      post = create(:post, user: user)
      create(:comment, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Like Comment'

      expect(page).to have_content 'Unlike Comment (1 Like)'
    end
  end
end
