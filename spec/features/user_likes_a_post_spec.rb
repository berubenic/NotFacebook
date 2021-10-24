require 'rails_helper'

RSpec.feature 'User likes a post' do
  context 'the user is on the home page' do
    scenario 'they like a post' do
      user = create(:user)
      create(:post, user: user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Like'

      expect(page).to have_content 'Unlike (1 Like)'
    end
  end
end
