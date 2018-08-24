class Item < ApplicationRecord
  PARAMS = %i[title description free niche_id category_id].freeze

  has_paper_trail

  has_one :shared_item, dependent: :destroy

  belongs_to :user
  belongs_to :niche, optional: true

  belongs_to :category, optional: true

  belongs_to :rent_item, optional: true

  validates :title, presence: true

  has_many :item_histories, dependent: :destroy

  belongs_to :free_item_request

  def self.search(search)
    return all unless search
    where('title ilike ?', "%#{search}%")
  end

  def display_created_at
    created_at.strftime '%B %e, %Y'
  end
end
