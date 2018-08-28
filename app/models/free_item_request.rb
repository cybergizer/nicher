class FreeItemRequest < ApplicationRecord
  acts_as_paranoid
  belongs_to :actual_owner, class_name: 'User', foreign_key: 'actual_owner_id'
  belongs_to :potential_owner, class_name: 'User', foreign_key: 'potential_owner_id'

  has_one :item, dependent: :nullify

  validates :item, presence: true
end
