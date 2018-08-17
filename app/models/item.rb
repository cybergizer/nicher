class Item < ApplicationRecord
  PARAMS = %i[title description niche_id category_id].freeze

  belongs_to :user
  belongs_to :niche, optional: true

  belongs_to :category, optional: true

  belongs_to :rent_item, optional: true

  validates :title, presence: true
end
