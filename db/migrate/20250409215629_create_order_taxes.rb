class CreateOrderTaxes < ActiveRecord::Migration[7.2]
  def change
    create_table :order_taxes do |t|
      t.references :order, null: false, foreign_key: true
      t.string :tax_name
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
