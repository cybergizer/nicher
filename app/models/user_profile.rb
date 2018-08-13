class UserProfile < ApplicationRecord
  belongs_to :user
  validates_presence_of :full_name, :city, :description
end
