class FeedController < ApplicationController
  def index
    @activities = current_user.all_activity
  end
end
