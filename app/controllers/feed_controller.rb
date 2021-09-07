class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @post = Post.new
    @posts = Post.all
    @pending_requests = User.find(current_user.pending_friendships.pluck(:user_id))
  end
end
