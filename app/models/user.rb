class User < ApplicationRecord
  has_many :items, dependent: :destroy

  has_many :niches, dependent: :delete_all

  has_one :user_profile, dependent: :destroy

  accepts_nested_attributes_for :user_profile, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
