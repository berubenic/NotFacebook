require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  fixtures :users, :posts

  describe '#new' do
    it 'has a 200 status code' do
      get '/posts/new'
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'creates post with valid attributes' do
      sign_in users(:user_one)
      post_params = {
        post: {
          body: 'Yay I am a post!'
        }
      }
      post '/posts', params: post_params
      expect(flash[:success]).to eq('Post succesfully created')
      expect(response).to have_http_status(302)
    end

    it 'does not create post with non-valid attributes' do
      sign_in users(:user_one)
      post_params = {
        post: {
          body: ''
        }
      }
      post '/posts', params: post_params
      expect(flash[:error]).to eq('Post is not valid')
      expect(response).to have_http_status(200)
    end
  end

  describe '#show' do
    it 'has a 200 status code' do
      post = posts(:first_post)
      get "/posts/#{post.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe '#edit' do
    it 'has a 200 status code' do
      post = posts(:first_post)
      get "/posts/#{post.id}/edit"
      expect(response).to have_http_status(200)
    end
  end

  describe '#update' do
    it 'updates post' do
      post = posts(:first_post)
      post_params = {
        post: {
          body: 'I updated this post'
        }
      }
      patch "/posts/#{post.id}", params: post_params
      expect(response).to have_http_status(302)
    end
  end

  describe '#destroy' do
    it 'destroys post' do
      post = posts(:first_post)
      delete "/posts/#{post.id}"
      expect(response).to have_http_status(302)
    end
  end
end
