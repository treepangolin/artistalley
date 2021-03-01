class Post < ApplicationRecord
  extend FriendlyId
  include ImageUploader::Attachment(:image)
  include PublicActivity::Common
  include Sluggable

  friendly_id :slug, use: :slugged
  has_many :comments, as: :commentable
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
  acts_as_votable

  belongs_to :user

  validate :journal_or_art?

  def journal_or_art?
    if title.blank? && body.blank? && image_data.blank?
      errors.add :base, :invalid, message: 'All fields are blank.'
    elsif (title.present? ^ body.present?) && image_data.blank?
      errors.add :base, :invalid, message: 'Both a title and body are required for journal posts.'
    end
  end
end
