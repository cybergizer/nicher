class RentItem < ApplicationRecord
  PARAMS = %i[niche_id category_id].freeze

  acts_as_paranoid

  has_one :item, dependent: :nullify
  belongs_to :owner, polymorphic: true
  belongs_to :tenant, polymorphic: true
  belongs_to :niche, optional: true
  belongs_to :category, optional: true
  enum status: { borrowed: 0, lend: 1 }
  accepts_nested_attributes_for :tenant
  validates :item, presence: true

  delegate :title, to: :item

  after_create :create_history

  def tenant_attributes=(attributes)
    self.tenant = Contact.create(attributes)
  end

  private
  def create_history
    ItemHistory.create(item: self.item, rent_item_id: self.id)
  end
end
