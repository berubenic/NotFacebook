class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @post = Post.new
    @posts = Post.all
    @pending_requests =
      Friendship.where(friend_id: @user.id, confirmed: false).pluck(:user_id)
  end
end
