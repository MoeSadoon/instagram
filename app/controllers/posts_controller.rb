class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @posts = Post.new
  end

  def create
    @post = Post.new(post_params, current_user)

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end


  def post_params
    params.require(:post).permit(:description, :image)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    message = Post.destroy_for_user(@post) ? 'Post deleted successfully' : 'You cannot delete this post'
    flash[:notice] = message
    redirect_to '/posts'
    end
  end


end
