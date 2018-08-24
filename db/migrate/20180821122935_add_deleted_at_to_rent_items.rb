class AddDeletedAtToRentItems < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_items, :deleted_at, :datetime
    add_index :rent_items, :deleted_at
  end
end
