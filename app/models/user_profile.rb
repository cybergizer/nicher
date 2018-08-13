class UserProfile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :full_name, :city, :description
  validates :avatar, file_size: { less_than: 1.megabytes }
end
