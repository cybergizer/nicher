class Category < ActiveRecord::Base
  has_many :items, dependent: :nullify

  has_ancestry

  validates :name, presence: true
  validates :name, length: { in: 3..15 }
end
