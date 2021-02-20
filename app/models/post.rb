class Post < ApplicationRecord
  before_create :set_slug

  include ImageUploader::Attachment(:image)
  extend FriendlyId

  friendly_id :slug, use: :slugged

  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  belongs_to :user

  private

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(16)
  end
end
