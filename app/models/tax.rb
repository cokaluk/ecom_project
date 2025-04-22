class Tax < ApplicationRecord
  belongs_to :province

  validates :tax_type, presence: true
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    [ "province" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "province_id", "tax_rate", "tax_type", "updated_at" ]
  end
end
