class Conversation < ApplicationRecord
  extend FriendlyId

  before_create :set_slug
  friendly_id :slug, use: :slugged
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy, counter_cache: true

  validates_presence_of :recipient, :subject, :sender

  scope :inbox, lambda { |user|
    Conversation.joins(:messages).where.not(messages: { user: user }).distinct
  }

  def unreads_for(recipient)
    messages.where.not(user: recipient).and(messages.where(read: false))
  end

  def unreads_for?(recipient)
    unreads_for(recipient).count.positive?
  end

  def replies?
    messages.count > 1
  end

  def mark_read_for(recipient)
    unreads = messages.where.not(user: recipient).and(messages.where(read: false))

    unreads.each do |message|
      message.read = true
    end
  end

  private

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(16)
  end
end
