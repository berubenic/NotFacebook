require 'rails_helper'

RSpec.feature 'User sees profile picture on navbar' do
  context 'the user is on the home page' do
    scenario 'they do not have a profile picture' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_css("img[src*='default_profile']")
    end

    scenario 'they upload a profile picture' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit profile'

      fill_in 'user_current_password', with: user.password
      attach_file('Profile image', Rails.root + 'spec/fixtures/green.png')

      click_on 'Update'

      find("a[href='/']", match: :first).click
      expect(page).to have_css("img[src*='green.png']")
    end
  end
end
