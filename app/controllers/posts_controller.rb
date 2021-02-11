class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    if @post.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:body, images: [])
    end
end
