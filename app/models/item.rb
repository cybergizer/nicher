class Item < ApplicationRecord
  PARAMS = [:title, :description, :free, :niche_id, :category_id, { attachments: [] }].freeze
  LIMIT_OF_ATTACHMENTS = 5
  scope :free, -> { where(free: true) }

  acts_as_paranoid
  audited on: :update

  has_one :shared_item, dependent: :destroy

  belongs_to :user
  belongs_to :niche, optional: true

  belongs_to :category, optional: true

  belongs_to :rent_item, optional: true

  validates :title, presence: true

  has_many :item_histories, dependent: :destroy

  belongs_to :free_item_request, optional: true

  mount_uploaders :attachments, ImageUploader
  validates :attachments, file_size: { less_than: 10.megabytes }
  validate :images_count_validation

  def images_count_validation
    errors.add(:attachments, 'must not contain more than 5 files') if attachments.size > LIMIT_OF_ATTACHMENTS
  end

  def self.search(search)
    return all unless search
    where('title ilike ?', "%#{search}%")
  end

  def display_created_at
    created_at.strftime '%B %e, %Y'
  end
end
