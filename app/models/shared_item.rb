class SharedItem < ApplicationRecord
  belongs_to :item

  before_create :generate_token, :set_expiration_date

  protected

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    generate_token if SharedItem.exists?(token: token)
  end

  def set_expiration_date
    self.expiration = Time.zone.now + 10.minute
  end
end
