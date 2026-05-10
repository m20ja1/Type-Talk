class PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(updated_at: :desc)
    @post = Post.new
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = Current.user.id
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.all.order(updated_at: :desc)
      render :index, status: :unprocessable_entity
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
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user == Current.user
      redirect_to posts_path
    end
  end
end
