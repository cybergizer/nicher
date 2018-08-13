class RentItem < ApplicationRecord
  has_one :item
  belongs_to :owner, polymorphic: true
  belongs_to :tenant, polymorphic: true
  enum status: { borrowed: 0, lend: 1 }
end
