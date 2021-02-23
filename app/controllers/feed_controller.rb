class FeedController < ApplicationController
  def index
    @activities = current_user.all_activity if user_signed_in?
  end
end
