class CreateFreeItemRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :free_item_requests do |t|

      t.timestamps
    end
  end
end
