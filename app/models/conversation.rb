class Conversation < ApplicationRecord
  extend FriendlyId

  before_create :set_slug
  friendly_id :slug, use: :slugged
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_presence_of :recipient, :subject, :sender

  def unread_for?(recipient)
    messages.where.not(user: recipient).and(messages.where(read: false)).count.positive?
  end

  private

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(16)
  end
end
