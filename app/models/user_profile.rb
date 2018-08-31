class UserProfile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :first_name
  validates :avatar, file_size: { less_than: 10.megabytes }
  validates :birthday, date: { before: Date.current, allow_blank: true }

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
