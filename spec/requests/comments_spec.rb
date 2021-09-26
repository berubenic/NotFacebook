require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  fixtures :users, :posts, :comments

  describe '#create' do
    it 'creates comment with valid attributes' do
      sign_in users(:user_one)
      post = posts(:first_post)
      comment_params = {
        comment: {
          body: 'Comment!'
        },
        post_id: post.id.to_s
      }
      post "/posts/#{post.id}/comments", params: comment_params
      expect(flash[:success]).to eq('Comment created!')
      expect(response).to have_http_status(302)
    end

    it 'does not create comment with non-valid attributes' do
      sign_in users(:user_one)
      post = posts(:first_post)
      comment_params = {
        comment: {
          body: ''
        },
        post_id: post.id.to_s
      }
      post "/posts/#{post.id}/comments", params: comment_params
      expect(flash[:error]).to eq('Something went wrong!')
      expect(response).to have_http_status(302)
    end
  end
end
