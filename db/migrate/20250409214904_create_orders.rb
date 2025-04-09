class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :sub_total
      t.integer :grand_total
      t.string :status

      t.timestamps
    end
  end
end
