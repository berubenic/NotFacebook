require 'rails_helper'

RSpec.describe 'Feed', type: :request do
  fixtures :users

  describe '#index' do
    it 'has a 200 status code' do
      sign_in users(:user_one)
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end
end
