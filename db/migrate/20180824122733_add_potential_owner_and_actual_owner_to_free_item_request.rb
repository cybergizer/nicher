class AddPotentialOwnerAndActualOwnerToFreeItemRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :free_item_requests, :potential_owner_id, :integer
    add_column :free_item_requests, :actual_owner_id, :integer
  end
end
