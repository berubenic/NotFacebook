require 'rails_helper'

RSpec.feature 'User creates post' do
  context 'the post is valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      fill_in 'post_body', with: 'Hello everyone!'
      click_on 'Post'

      expect(page).to have_content 'Post successfully created'
    end
  end

  context 'the post is not valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      fill_in 'post_body', with: 'Hi'
      click_on 'Post'

      expect(page).to have_content 'Body is too short (minimum is 5 characters)'
    end
  end
end
