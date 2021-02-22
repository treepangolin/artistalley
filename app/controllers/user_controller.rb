class UserController < ApplicationController
  # Separate User controller to handle showing user profiles
  # Independent from Devise
  before_action :set_user

  def show
    @header = 'Wall'
    render 'posts', locals: { posts: @user.posts }
  end

  def likes
    @header = 'Likes'
    render 'posts', locals: { posts: @user.find_liked_items }
  end

  def follow
    if current_user.following?(@user)
      current_user.unfollow(@user)

      redirect_to @user, secondary: "Stopped following #{@user.username}."
    else
      new_follow = current_user.follow(@user)

      redirect_to @user, notice: "Now following #{@user.username}!" if new_follow.save
    end
  end

  private

  def set_user
    @user = User.find_by_username(params[:id])
  end
end
