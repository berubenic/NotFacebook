require 'rails_helper'

RSpec.feature 'User edits a post' do
  context 'the user is on the home page' do
    scenario 'the form is valid' do
      user = create(:user)
      create(:post, user: user, body: 'I am a post')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit'

      fill_in 'post_body', with: 'I am a edited post'
      click_on 'Post'

      expect(page).to have_content 'I am a edited post'
    end

    scenario 'the form is not valid' do
      user = create(:user)
      create(:post, user: user, body: 'I am a post')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit'

      fill_in 'post_body', with: ''
      click_on 'Post'

      expect(page).to have_content 'Body is too short'
    end
  end
end
