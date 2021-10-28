require 'rails_helper'

RSpec.feature 'User sees five latest comments from post on home page' do
  context 'the post has five comments' do
    scenario 'the user is on the home page' do
      user = create(:user)
      post = create(:post, user: user)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('I am a comment', count: 5)
    end
  end

  context 'the post has six comments' do
    scenario 'the user is on the home page' do
      user = create(:user)
      post = create(:post, user: user)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)
      create(:comment, user: user, post: post)

      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('I am a comment', count: 5)
    end
  end
end
