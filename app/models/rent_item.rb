class RentItem < ApplicationRecord
  enum status: { borrowed: 0, lend: 1 }
end
