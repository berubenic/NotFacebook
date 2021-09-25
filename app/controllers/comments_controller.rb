class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[post_id])
    comment = post.comments.build(comment_params)
    if comment.save
      flash[:success] = 'Comment succesfully created'
      redirect_to post
    else
      flash[:error] = 'Comment is not valid'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
