class SharedItem < ApplicationRecord
  has_secure_token :token

  belongs_to :item

  before_create :set_expiration_date

  protected

  def set_expiration_date
    self.expiration = Time.zone.now + 10.minute
  end
end
