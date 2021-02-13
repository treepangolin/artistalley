class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index] # Require authentication to [create, edit] posts

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
    # Attach current user to the post being created
    # Requires before_action above, else Rails will complain about current_user being nil
    @post = Post.new(post_params.merge(user_id: current_user.id))

    if @post.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:body, :image)
    end
end
