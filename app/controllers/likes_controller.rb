class LikesController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def create
    if liked?
      like.destroy_all
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def like
    Like.where(user_id: current_user.id, post_id: params[:post_id])
  end

  def liked?
    like.exists?
  end
end
