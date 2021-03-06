class Message < ApplicationRecord
  attr_accessor :subject, :recipient

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :subject, :recipient
  validate :recipient_exists?

  def recipient_exists?
    errors.add(:recipient, 'does not exist') if User.find_by_username(recipient).nil?
  end
end
