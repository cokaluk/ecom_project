class ChangePriceToCentsInProducts < ActiveRecord::Migration[7.2]
  def change
    rename_column :products, :price, :old_price

    add_column :products, :price, :integer

    Product.find_each do | product |
      product.update_column(:price, (product.old_price.to_f * 100).round)
    end

    remove_column :products, :old_price
  end
end
