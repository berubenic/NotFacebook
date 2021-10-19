require 'rails_helper'

RSpec.feature 'User logs out' do
  context 'they did not use omniauth to log in' do
    scenario 'they see the log out link' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Logout'

      expect(page).to have_content 'Signed out successfully.'
    end
  end

  context 'they used omniauth to log in' do
    scenario 'they see the log out link' do
      visit root_path

      set_omniauth('facebook')

      click_on 'Sign in with Facebook'

      click_on 'Logout'

      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
