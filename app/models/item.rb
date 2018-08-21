class Item < ApplicationRecord
  PARAMS = %i[title description niche_id category_id].freeze

  has_one :shared_item, dependent: :destroy
  attr_readonly :title

  belongs_to :user
  belongs_to :niche, optional: true

  belongs_to :category, optional: true

  belongs_to :rent_item, optional: true

  validates :title, presence: true

  def self.search(search)
    return all unless search
    where('title ilike ?', "%#{search}%")
  end

  def display_created_at
    created_at.strftime '%B %e, %Y'
  end
end
