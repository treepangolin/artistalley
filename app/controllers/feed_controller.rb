class FeedController < ApplicationController
  before_action :set_activities

  def index; end

  private

  def set_activities
    @activities = current_user.all_activity if user_signed_in?
  end
end
