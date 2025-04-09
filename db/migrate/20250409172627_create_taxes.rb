class CreateTaxes < ActiveRecord::Migration[7.2]
  def change
    create_table :taxes do |t|
      t.string :tax_type
      t.decimal :tax_rate
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
