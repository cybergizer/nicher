class AddFreeToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :free, :boolean
  end
end
