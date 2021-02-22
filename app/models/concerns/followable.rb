module Followable
  extend ActiveSupport::Concern

  def following?(user)
    followed_users.exists?(user.id)
  end

  def follow(user)
    active_follows.new(followed_id: user.id)
  end

  def unfollow(user)
    active_follows.find_by(followed_id: user.id).destroy
  end
end
