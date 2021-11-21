# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = find_existing_like(params)
    if like
      flash[:alert] = 'It has already liked!'
      redirect_to post_path(post)
    end
    case params[:category]
    when 'post'
      Like.create(user_id: params[:user_id], post_id: params[:post_id], category: params[:category])
    when 'comment'
      Like.create(user_id: params[:user_id], comment_id: params[:comment_id], category: params[:category])
    end
    flash[:success] = 'Liked!'

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
    params.permit(:user_id, :post_id, :comment_id, :category)
  end

  def find_existing_like(params)
    category = params[:category]
    case category
    when 'post'
      find_existing_post_like(params)
    when 'comment'
      find_existing_comment_like(params)
    end
  end

  def find_existing_post_like(params)
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
