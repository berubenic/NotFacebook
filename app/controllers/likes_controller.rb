class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])

    if params[:post_id]
      like = Like.find_by(user_id: current_user.id, post_id: post.id)
    else
      comment = Comment.find(params[:comment_id]) if params[:comment_id]
      like = Like.find_by(user_id: current_user.id, comment_id: comment.id)
    end
    if like
      flash[:alert] = 'Post already liked!'
    else
      Like.create(like_params)
      flash[:success] = 'Post Liked!'
    end
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:id])
    like = Like.find_by(user_id: current_user.id, post_id: post.id)
    like.destroy

    redirect_to post
  end

  def destroy_post_like
    post = Post.find(params[:id])
    like = Like.find_by(user_id: current_user.id, post_id: post.id)
    like.destroy

    redirect_to post
  end

  def destroy_comment_like
    comment = Comment.find(params[:id])
    like = Like.find_by(user_id: current_user.id, comment_id: comment.id)
    like.destroy

    redirect_to comment.post
  end

  private

  def like_params
    params.permit(:user_id, :post_id, :comment_id)
  end
end
