class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    user = current_user
    @post = user.posts.build(post_params)
    if @post.save
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:body, comments_attributes: %i[id body user_id post_id])
  end
end
