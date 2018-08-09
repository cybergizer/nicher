class Niche < ApplicationRecord
  has_many :items, dependent: :delete_all
  belongs_to :user
  has_ancestry
  validates :name, presence: true
end
