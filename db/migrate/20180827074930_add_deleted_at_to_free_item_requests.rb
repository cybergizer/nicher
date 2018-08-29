class AddDeletedAtToFreeItemRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :free_item_requests, :deleted_at, :datetime
    add_index :free_item_requests, :deleted_at
  end
end
