require 'rails_helper'

RSpec.feature 'User unlikes a comment' do
  context 'user is on the home page' do
    scenario 'they ulike a  comment' do
      user = create(:user)
      post = create(:post, user: user)
      comment = create(:comment, user: user, post: post)
      create(:like, user: user, comment: comment)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Unlike Comment'

      expect(page).to have_content 'Like Comment (0 Likes)'
    end
  end
end
