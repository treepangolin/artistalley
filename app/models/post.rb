class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  belongs_to :user
end
