class AddRentItemToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :rent_item, foreign_key: true
  end
end
