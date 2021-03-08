class Message < ApplicationRecord
  attr_accessor :subject, :recipient

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body
  validates_presence_of :subject, :recipient, if: proc { |m| m.conversation_id.blank? }
  validate :recipient_exists?, unless: proc { |m| m.recipient.blank? }

  def recipient_exists?
    errors.add(:recipient, 'does not exist') if User.find_by_username(recipient).nil?
  end
end
