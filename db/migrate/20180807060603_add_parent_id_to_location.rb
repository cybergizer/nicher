class AddParentIdToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :parent_id, :integer
  end
end
