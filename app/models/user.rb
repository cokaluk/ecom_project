class User < ApplicationRecord
  belongs_to :province

  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :province_id, presence: true

  with_options unless: :guest? do
    validates :name, presence: true
    validates :postal_code, presence: true
    validates :address, presence: true
    validates :city, presence: true
  end

  def password_required?
    !guest? && super
  end

  def email_required?
    !guest? && super
  end
end
