# frozen_string_literal: true

class LikesController < ApplicationController
  def create_post_like
    post = Post.find(params[:post_id])

    like = find_existing_post_like(params)

    if like
      flash[:alert] = 'Post already liked!'
    else
      Like.create(user_id: params[:user_id], post_id: params[:post_id])
      flash[:success] = 'Post Liked!'
    end
    redirect_to post_path(post)
  end

  def create_comment_like
    post = Post.find(params[:post_id])

    like = find_existing_comment_like(params)

    if like
      flash[:alert] = 'Comment already liked!'
    else
      Like.create(user_id: params[:user_id], comment_id: params[:comment_id])
      flash[:success] = 'Comment Liked!'
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

  def find_existing_post_like(params)
    binding.pry
    post = Post.find(params[:post_id])
    like = Like.find_by(user_id: current_user.id, post_id: post.id) if post
    like
  end

  def find_existing_comment_like(params)
    comment = Comment.find(params[:comment_id]) if params[:comment_id]
    like = Like.find_by(user_id: current_user.id, comment_id: comment.id) if comment
    like
  end
end
