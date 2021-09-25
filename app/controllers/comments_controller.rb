class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment].permit(:body, :user_id, :post_id))
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to @post

    else
      flash[:error] = 'Something went wrong!'
      redirect_to @post

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, comments_attributes: %i[id body user_id post_id])
  end
end
