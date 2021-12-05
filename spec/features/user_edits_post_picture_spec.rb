require 'rails_helper'

RSpec.feature 'User edits post picture' do
  context 'the user is on the home page' do
    scenario 'they remove the picture' do
      user = create(:user)
      post = create(:post, user: user, body: 'I am a post')
      post.post_image.attach(
        io: File.open(Rails.root + 'spec/fixtures/green.png'),
        filename: 'green.png',
        content_type: 'img/png'
      )
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit'

      attach_file('Add Image', Rails.root + 'spec/fixtures/green_one.png')
      click_on 'Post'

      expect(page).to have_content 'Post successfully updated.'
    end

    scenario 'they change the picture' do
      user = create(:user)
      post = create(:post, user: user, body: 'I am a post')
      post.post_image.attach(
        io: File.open(Rails.root + 'spec/fixtures/green.png'),
        filename: 'green.png',
        content_type: 'img/png'
      )
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Edit'

      attach_file('Add Image', Rails.root + 'spec/fixtures/green_one.png')
      click_on 'Post'

      expect(page).to have_css "img[src*='green_one.png']"
    end
  end
end
