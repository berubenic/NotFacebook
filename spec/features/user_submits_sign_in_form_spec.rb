require 'rails_helper'

RSpec.feature 'User submits the sign in form' do
  context 'the form is valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content 'Signed in successfully'
    end
  end
  context 'the form is invalid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email

      find('input[type="submit"]').click

      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  context 'they use facebook login' do
    scenario 'they see the page with the link' do
      visit root_path
      set_omniauth('facebook')
      click_on 'Sign in with Facebook'
      expect(page).to have_content 'Successfully authenticated from Facebook account'
    end
  end
end
