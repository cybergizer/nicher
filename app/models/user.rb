class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :niches, dependent: :delete_all
  has_many :categories, dependent: :destroy

  has_one :user_profile, dependent: :destroy

  accepts_nested_attributes_for :user_profile, allow_destroy: true

  has_many :lend_items, class_name: 'RentItem', as: :owner
  has_many :borrowed_items, class_name: 'RentItem', as: :tenant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :sent_requests, class_name: 'FreeItemRequest', foreign_key: 'potential_owner_id', dependent: :destroy
  has_many :pending_requests, class_name: 'FreeItemRequest', foreign_key: 'actual_owner_id', dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  delegate :full_name, to: :user_profile
end
