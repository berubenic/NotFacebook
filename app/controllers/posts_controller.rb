class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    user = current_user
    @post = user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        flash[:success] = 'Post succesfully created'
        format.html { redirect_to posts_path }
      else
        flash[:error] = 'Post is not valid'
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@post, partial: 'posts/form', locals: { post: @post })
        end
        format.html { render :new }
      end
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
