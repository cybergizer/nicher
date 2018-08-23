class Niche < ApplicationRecord
  PARAMS = %i[name url parent_id].freeze

  has_many :items, dependent: :nullify
  has_many :rent_items, dependent: :nullify

  belongs_to :user

  has_ancestry

  validates :name, presence: true
  validates :url, format: { with: /[A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&;\?\#\/.=]+/,
                            message: 'Invalid url.',
                            allow_blank: true }

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
