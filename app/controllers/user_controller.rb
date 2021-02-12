class UserController < ApplicationController
  # Separate User controller to handle showing user profiles
  # Independent from Devise

  def show
    @user = User.find_by_username!(params[:id])
  end
end
