class Post < ApplicationRecord
  has_one_attached :image

  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  belongs_to :user
end
