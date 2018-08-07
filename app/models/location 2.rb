class Location < ApplicationRecord
  has_many :items, dependent: :delete_all
  has_many :children, class_name: 'Location', foreign_key: 'parent_id', dependent: :delete_all
  belongs_to :parent, class_name: 'Location', foreign_key: 'parent_id', optional: true
  belongs_to :user

  validates :name, presence: true
end
