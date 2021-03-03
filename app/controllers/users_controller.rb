class UsersController < ApplicationController
  # Separate User controller to handle showing user profiles
  # Independent from Devise
  before_action :set_user

  def show
    render 'posts', locals: { posts: @user.posts }
  end

  def likes
    render 'posts', locals: { posts: @user.find_liked_items }
  end

  def follow
    if current_user.following?(@user)
      current_user.unfollow(@user)

      flash[:secondary] = "Stopped following #{@user.username}."
    else
      new_follow = current_user.follow(@user)

      flash[:notice] = "Now following #{@user.username}!" if new_follow.save
    end

    redirect_back fallback_location: @user
  end

  def followers
    render 'follows', locals: { users: @user.followers }
  end

  private

  def set_user
    @user = User.find_by_username(params[:id])
  end
end
