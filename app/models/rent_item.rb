class RentItem < ApplicationRecord
  has_one :item, dependent: :nullify
  belongs_to :owner, polymorphic: true
  belongs_to :tenant, polymorphic: true
  enum status: { borrowed: 0, lend: 1 }
  accepts_nested_attributes_for :tenant
  validates :item, presence: true

  delegate :title, to: :item

  def tenant_attributes=(attributes)
    self.tenant = Contact.create(attributes)
  end
end
