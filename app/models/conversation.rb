class Conversation < ApplicationRecord
  extend FriendlyId
  include Sluggable

  friendly_id :slug, use: :slugged
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
end
