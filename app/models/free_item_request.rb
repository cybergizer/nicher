class FreeItemRequest < ApplicationRecord
  belongs_to :actual_owner
  belongs_to :potential_owner
  has_one :item, dependent: :destroy
end
