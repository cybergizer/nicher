class ItemHistory < ApplicationRecord
  belongs_to :item
  validates :item, presence: true

  def rent_item
    RentItem.only_deleted.find_by_id(rent_item_id)
  end

  def returned_at
    rent_item.deleted_at.strftime '%e %b %Y %k:%M'
  end

  def borrowed_at
    rent_item.created_at.strftime '%e %b %Y %k:%M'
  end
end
