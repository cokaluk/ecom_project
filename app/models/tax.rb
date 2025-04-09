class Tax < ApplicationRecord
  belongs_to :province

  validates :tax_type, presence: true
  validates :tax_rate, numericality: { greater_than: 0 }
end
