require 'rails_helper'

RSpec.feature 'User creates post with image' do
  context 'the post is valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      fill_in 'post_body', with: 'My first image'
      attach_file('Post image', Rails.root + 'spec/fixtures/green.png')

      click_on 'Post'
      expect(page).to have_css("img[src*='green.png']")
    end
  end

  context 'the post is not valid' do
    scenario 'they see the page with the form' do
      user = create(:user)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      fill_in 'post_body', with: 'My first image'
      attach_file('Post image', Rails.root + 'spec/fixtures/too_big.png')

      click_on 'Post'
      expect(page).to_not have_css("img[src*='too_big.png']")
    end
  end
end
