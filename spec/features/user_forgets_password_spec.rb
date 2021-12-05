require 'rails_helper'

RSpec.feature 'User submits the forgot password form' do
  context 'the form is valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      click_on 'Forgot your password?'

      fill_in 'user_email', with: user.email

      find('input[type="submit"]').click

      expect(
        page
      ).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    end
  end
  context 'the user does not exist' do
    scenario 'they see the page with the form' do
      user = build(:user)

      visit root_path

      click_on 'Forgot your password?'

      fill_in 'user_email', with: user.email

      find('input[type="submit"]').click

      expect(page).to have_content 'Email not found'
    end
  end
end
