# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment =
      post.comments.build(params[:comment].permit(:body, :user_id, :post_id))
    comment.user = current_user
    if comment.save
      flash[:notice] = 'Comment created!'
    else
      flash[:alert] = 'Something went wrong!'
    end
    redirect_to post
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    flash[:notice] = 'Comment deleted!'
    redirect_to post
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:body, comments_attributes: %i[id body user_id post_id])
  end
end
