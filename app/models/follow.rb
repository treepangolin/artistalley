class Follow < ApplicationRecord
  belongs_to :followed_user, class_name: 'User', foreign_key: :followed_id
  belongs_to :following_user, class_name: 'User', foreign_key: :follower_id
end
