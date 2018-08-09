class Item < ApplicationRecord
  belongs_to :user
  belongs_to :niche, optional: true

  validates :title, presence: true
end
