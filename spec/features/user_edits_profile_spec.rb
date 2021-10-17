require 'rails_helper'

RSpec.feature 'User submits the edit form' do
  context 'the form is valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit profile'

      fill_in 'user_email', with: 'email@email.com'
      fill_in 'user_current_password', with: user.password
      attach_file('Profile image', Rails.root + 'spec/fixtures/green.png')

      click_on 'Update'

      user = User.first
      expect(user.email).to eq('email@email.com')
      expect(user.profile_image.filename).to eq('green.png')
    end
  end
  context 'the form is not valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit profile'

      fill_in 'user_email', with: 'email@email.com'
      attach_file('Profile image', Rails.root + 'spec/fixtures/green.png')

      click_on 'Update'

      user = User.first
      expect(page).to have_content "Current password can't be blank"
    end
  end
end
