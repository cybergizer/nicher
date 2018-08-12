class Item < ApplicationRecord
  PARAMS = %i[title description].freeze

  belongs_to :user

  validates :title, presence: true
end
