class Category < ActiveRecord::Base
  PARAMS = %i[name parent_id].freeze

  has_many :items, dependent: :nullify

  has_ancestry

  validates :name, presence: true
  validates :name, length: { in: 3..15 }
end
