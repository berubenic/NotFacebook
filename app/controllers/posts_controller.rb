class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    user = current_user
    @post = Post.new(post_params)
    @post.user = user
    if @post.valid?
      @post.save!
      flash[:success] = 'Post succesfully created'
      redirect_to @post
    else
      flash[:error] = 'Post is not valid'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
