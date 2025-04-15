class AddGuestToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :guest, :boolean
  end
end
