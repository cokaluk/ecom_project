class User < ApplicationRecord
  belongs_to :province
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :province_id, presence: true

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :city, presence: true
end
