class Item < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true

  validates :title, presence: true
end
