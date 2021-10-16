require 'rails_helper'

RSpec.feature 'User submits a form' do
  context 'the form is valid' do
    scenario 'they see the page with the form' do
      user = build(:user)

      visit root_path

      click_on 'Sign up', match: :first

      fill_in 'user_email', with: user.email
      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end

  context 'the form is invalid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      click_on 'Sign up', match: :first

      fill_in 'user_email', with: user.email
      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
