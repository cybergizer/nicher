class User < ApplicationRecord
  PARAMS = [{ user_profile_attributes: %i(first_name last_name city description
                                          avatar avatar_cache sex phone birthday) }].freeze
  has_many :items, dependent: :destroy
  has_many :niches, dependent: :delete_all
  has_many :categories, dependent: :destroy
  has_one :user_profile, dependent: :destroy

  accepts_nested_attributes_for :user_profile, allow_destroy: true

  has_many :lend_items, class_name: 'RentItem', as: :owner
  has_many :borrowed_items, class_name: 'RentItem', as: :tenant

  has_many :sent_requests, class_name: 'FreeItemRequest', foreign_key: 'potential_owner_id', dependent: :destroy
  has_many :pending_requests, class_name: 'FreeItemRequest', foreign_key: 'actual_owner_id', dependent: :destroy

  TEMP_EMAIL_PREFIX = 'change@me'.freeze
  TEMP_EMAIL_REGEX = /\Achange@me/

  delegate :first_name, to: :user_profile

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  def email_verified?
    email && email !~ TEMP_EMAIL_REGEX
  end
end
