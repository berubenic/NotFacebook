require 'rails_helper'

RSpec.feature 'User unlikes a post' do
  context 'the user is on the home page' do
    scenario 'they unlike a post' do
      user = create(:user)
      post = create(:post, user: user)
      create(:like, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Unlike'

      expect(page).to have_content 'Like (0 Likes)'
    end
  end
end
