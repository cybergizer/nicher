class Niche < ApplicationRecord
  PARAMS = %i[name parent_id].freeze

  has_many :items, dependent: :delete_all

  belongs_to :user

  has_ancestry

  validates :name, presence: true

  def add(niche)
    niche.parent = self
    niche.save
  end

  def remove(niche)
    our_niche = self
    niche = our_niche.descendants.find_by(id: niche.id)
    return unless niche
    niche.parent = nil
    niche.save
  end
end
