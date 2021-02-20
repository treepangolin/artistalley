class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index] # Require authentication to [create, edit] posts

  def index
    @posts = Post.all
  end

  def show
    @comments = params[:comment] ? @post.comments.where(id: params[:comment]) : @post.comments.where(parent_id: nil)
    @liked = Like.where(user_id: current_user.id, post_id: params[:id]).any? if user_signed_in?
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    # Attach current user to the post being created
    # Requires before_action above, else Rails will complain about current_user being nil
    @post = Post.new(post_params.merge(user_id: current_user.id))

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.destroy
    end

    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
