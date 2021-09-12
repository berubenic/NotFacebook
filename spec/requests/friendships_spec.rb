require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  fixtures :users, :friendships

  describe '#index' do
    it 'has a 200 status code' do
      sign_in users(:user_one)
      get '/'
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'creates friendship' do
      u1 = users(:user_one)
      u2 = users(:user_two)
      sign_in u1
      params = {
        user_id: u1.id,
        friend_id: u2.id
      }
      post '/friendships', params: params
      expect(flash[:success]).to eq('Friend added!')
      expect(response).to have_http_status(302)
    end

    it 'does not create friendship when already sent' do
      u1 = users(:user_one)
      u3 = users(:user_three)
      sign_in u1
      params = {
        user_id: u1.id,
        friend_id: u3.id
      }
      post '/friendships', params: params
      expect(flash[:notice]).to eq('You have already sent a friendship request to this user')
      expect(response).to have_http_status(302)
    end

    it 'does not create friendship when already recieved' do
      u1 = users(:user_one)
      u4 = users(:user_four)
      sign_in u1
      params = {
        user_id: u1.id,
        friend_id: u4.id
      }
      post '/friendships', params: params
      expect(flash[:notice]).to eq('A friend request has already been sent to you')
      expect(response).to have_http_status(302)
    end
  end

  describe '#update' do
    it 'updates friendship' do
      u1 = users(:user_one)
      u4 = users(:user_four)
      sign_in u1
      params = {
        id: u4.id
      }
      patch "/friendships/#{u4.id}", params: params
      expect(flash[:notice]).to eq('Friend Request Accepted!')
      expect(response).to have_http_status(302)
    end
  end

  describe '#destroy' do
    it 'destroys friendship' do
      u1 = users(:user_one)
      u4 = users(:user_four)
      sign_in u1
      params = {
        id: u4.id
      }
      delete "/friendships/#{u4.id}", params: params
      expect(flash[:notice]).to eq('Friend Request Declined!')
      expect(response).to have_http_status(302)
    end
  end
end
