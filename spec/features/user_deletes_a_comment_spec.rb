require 'rails_helper'

RSpec.feature 'User deletes a comment' do
  context 'they are on the home page' do
    scenario 'they delete a comment on their own post' do
      user = create(:user)
      create(:post, user: user, body: 'my own post')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Add Comment'

      fill_in 'comment_body', with: 'I am a comment'
      click_on 'Create Comment'

      within('div', class: 'comment-actions') do
        click_on 'Delete'
      end

      expect(page).to_not have_content 'I am a comment'
    end

    scenario 'they delete a comment on their own post' do
      user = create(:user)
      post = create(:post, user: user, body: 'my own post')
      create(:comment, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      within('div', class: 'comment-actions') do
        click_on 'Delete'
      end

      expect(page).to_not have_content 'I am a comment'
    end

    scenario 'they delete a comment on a friends post' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: user, friend: friend_one, confirmed: true)
      create(:post, user: friend_one, body: 'my own post')

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Add Comment'

      fill_in 'comment_body', with: 'I am a comment'
      click_on 'Create Comment'

      click_on 'Delete'

      expect(page).to_not have_content 'I am a comment'
    end
  end
end
