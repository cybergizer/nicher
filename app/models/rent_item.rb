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

  def tenant_attributes=(attributes)
    self.tenant = Contact.create(attributes)
  end

  def rent_item
    RentItem.unscoped { super }
  end
end
