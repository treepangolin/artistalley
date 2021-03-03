class Message < ApplicationRecord
  attr_accessor :subject, :recipient

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :subject, :recipient
end
