class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = Like.find_by(user_id: current_user.id, post_id: post.id)
    if like
      flash[:alert] = 'Post already liked!'
    else
      Like.create(like_params)
      flash[:success] = 'Post Liked!'
    end
    redirect_to post_path(post)
  end

  private

  def like_params
    params.permit(:user_id, :post_id)
  end
end
