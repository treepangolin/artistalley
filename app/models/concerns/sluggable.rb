module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(16)
  end
end
