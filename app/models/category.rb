class Category < ActiveRecord::Base
  has_many :items, dependent: :nullify

  has_ancestry

  validates :name, presence: true
end
