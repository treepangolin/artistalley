class Post < ApplicationRecord
  has_one_attached :image
  has_many :comments, as: :commentable
  
  belongs_to :user
end
