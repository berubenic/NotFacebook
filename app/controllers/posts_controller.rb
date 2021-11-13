# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    friend_ids = current_user.friends.pluck(:id)
    friend_ids << current_user
    @posts = Post.where(user_id: friend_ids).order(created_at: :desc).includes(:user, :post_image_attachment)
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create(user = current_user)
    @post = user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post successfully created'
        format.html { redirect_to posts_path }
      else
        flash[:alert] = 'Post is not valid'
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
      flash[:notice] = 'Post successfully updated.'
      redirect_to @post
    else
      flash[:alert] = 'An error prevented the post from being updated.'
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
    params.require(:post).permit(:body, :post_image, comments_attributes: %i[id body user_id post_id])
  end
end
