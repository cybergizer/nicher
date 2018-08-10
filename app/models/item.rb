class Item < ApplicationRecord
  PARAMS = %i[title description niche_id].freeze

  belongs_to :user
  belongs_to :niche, optional: true

  validates :title, presence: true
end
