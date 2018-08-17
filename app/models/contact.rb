class Contact < ApplicationRecord
  has_many :lend_items, class_name: 'RentItem', as: :owner
  has_many :borrowed_items, class_name: 'RentItem', as: :tenant
  validates :name, presence: true
end
