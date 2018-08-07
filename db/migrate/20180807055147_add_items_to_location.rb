class AddItemsToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :location, foreign_key: true
  end
end
