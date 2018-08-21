class Item < ApplicationRecord
  PARAMS = %i[title description niche_id category_id].freeze
  has_paper_trail

  has_one :shared_item, dependent: :destroy

  belongs_to :user
  belongs_to :niche, optional: true

  belongs_to :category, optional: true

  belongs_to :rent_item, -> { with_deleted }, optional: true

  validates :title, presence: true

  def self.search(search)
    return all unless search
    where('title ilike ?', "%#{search}%")
  end

  def display_created_at
    created_at.strftime '%B %e, %Y'
  end
end

Item.includes(:rent_item).all
