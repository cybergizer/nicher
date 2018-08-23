class ItemHistory < ApplicationRecord
  belongs_to :item
  validates :item, presence: true

  def find
    RentItem.only_deleted.find_by_id(rent_item_id)
  end
end
