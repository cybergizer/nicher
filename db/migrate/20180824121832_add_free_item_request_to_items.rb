class AddFreeItemRequestToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :free_item_request, foreign_key: true
  end
end
