class Identity < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: %s[provider]

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

  def add_identity(user)
    return if self.user == user
    self.user = user
    save!
  end
end
