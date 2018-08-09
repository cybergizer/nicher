class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :niches, class_name: 'Niche', dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
