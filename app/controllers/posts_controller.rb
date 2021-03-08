class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like]
  before_action :authenticate_user!, except: %i[show index] # Require authentication to [create, edit] posts
  load_and_authorize_resource

  def index
    @posts = Post.all
  end

  def show
    @comments = params[:comment] ? @post.comments.where(id: params[:comment]) : @post.comments.where(parent_id: nil)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    # Attach current user to the post being created
    # Requires before_action above, else Rails will complain about current_user being nil
    @post = Post.new(post_params.merge(user: current_user))

    respond_to do |format|
      if @post.save
        @post.create_activity(key: 'post.create', owner: current_user)
        format.html { redirect_to @post, notice: 'Posted successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post edited successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user)
  end

  def like
    case params[:format]
    when 'like'
      @post.create_activity(key: 'post.like', owner: current_user)
      @post.liked_by current_user
    when 'unlike'
      like_activity = PublicActivity::Activity.find_by(
        trackable_type: 'Post',
        trackable_id: @post.id,
        owner_id: current_user.id,
        key: 'post.like'
      )

      like_activity&.destroy
      @post.unliked_by current_user
    end

    redirect_to @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
