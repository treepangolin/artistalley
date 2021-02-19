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

  private

  def set_user
    @user = User.find_by_username!(params[:id])
  end
end
