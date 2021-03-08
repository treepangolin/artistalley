class Invite < ApplicationRecord
  before_create :set_code

  belongs_to :user, optional: true

  private

  def set_code
    self.code = SecureRandom.hex(3)
    self.redeemed = false
  end
end
