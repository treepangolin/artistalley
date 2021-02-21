class UserController < ApplicationController
  # Separate User controller to handle showing user profiles
  # Independent from Devise
  before_action :set_user

  def show
    @header = 'Wall'
  end

  def likes
    @header = 'Likes'
  end

  def follow
    if current_user.following?(@user)
      current_user.unfollow(@user)

      flash[:message] = "Stopped following #{@user.username}"
      redirect_to @user
    else
      new_follow = current_user.active_follows.new(followed_id: @user.id)

      if new_follow.save
        flash[:message] = "Now following #{@user.username}"
        redirect_to @user
      end
    end
  end

  private

  def set_user
    @user = User.find_by_username!(params[:id])
  end
end
