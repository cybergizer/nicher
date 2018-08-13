class RentItem < ApplicationRecord
  has_one :item
  enum status: { borrowed: 0, lend: 1 }
end
