class Item < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  has_paper_trail
end
