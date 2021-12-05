require 'rails_helper'

RSpec.feature 'user sees notifications' do
  context 'they recieve a friend request' do
    scenario 'they are on the home page' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('Notifications (1)')
    end

    scenario 'they view their notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      expect(page).to have_content 'friend one sent you a friend request.'
    end

    scenario 'they go to their notification' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      click_on 'friend one sent you a friend request.'
      expect(page).to_not have_content 'You have no pending friend requests.'
    end

    scenario 'they go to their notification' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      create(:friendship, user: friend_one, friend: user, confirmed: false)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      click_on 'friend one sent you a friend request.'
      expect(page).to have_content 'Notifications (0)'
    end
  end

  context 'they recieve a like on a post' do
    scenario 'they are on the home page' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      create(:like, post: post, user: friend_one)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('Notifications (1)')
    end

    scenario 'they view their notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      create(:like, post: post, user: friend_one)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      expect(page).to have_content 'friend one liked your post.'
    end

    scenario 'they go their notification' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      create(:like, post: post, user: friend_one)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      click_on 'friend one liked your post'
      expect(page).to have_content 'Notifications (0)'
    end
  end

  context 'they recieve a like on a comment' do
    scenario 'they are on the home page' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: user, post: post)

      # mark comment notification as seen
      notification = user.notifications.find_by(comment_id: comment.id)
      notification.seen = true
      notification.save

      # ---
      create(:like, comment: comment, user: friend_one, category: 'comment')
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('Notifications (1)')
    end

    scenario 'they view their notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: user, post: post)

      # mark comment notification as seen
      notification = user.notifications.find_by(comment_id: comment.id)
      notification.seen = true
      notification.save

      # ---
      create(:like, comment: comment, user: friend_one, category: 'comment')
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'

      expect(page).to have_content 'friend one liked your comment.'
    end

    scenario 'they go their notification' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: user, post: post)

      # mark comment notification as seen
      notification = user.notifications.find_by(comment_id: comment.id)
      notification.seen = true
      notification.save

      # ---
      create(:like, comment: comment, user: friend_one, category: 'comment')
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      click_on 'friend one liked your comment.'

      expect(page).to have_content 'Notifications (0)'
    end
  end

  context 'they recieve a comment on a post' do
    scenario 'they are on the home page' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: friend_one, post: post)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      expect(page).to have_content('Notifications (1)')
    end

    scenario 'they view their notifications' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: friend_one, post: post)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'

      expect(page).to have_content 'friend one commented on your post.'
    end

    scenario 'they go to their notification' do
      user = create(:user)
      friend_one = create(:user, first_name: 'friend', last_name: 'one')
      friendship =
        create(:friendship, user: friend_one, friend: user, confirmed: true)

      # mark friendship notification as seen
      notification = user.notifications.find_by(friendship_id: friendship.id)
      notification.seen = true
      notification.save

      # ---
      post = create(:post, user: user)
      comment = create(:comment, user: friend_one, post: post)
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      find('input[type="submit"]').click

      click_on 'Notifications'
      click_on 'friend one commented on your post.'

      expect(page).to have_content 'Notifications (0)'
    end
  end
end
