class Category < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true
end
