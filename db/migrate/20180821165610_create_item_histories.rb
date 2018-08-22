class CreateItemHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_histories do |t|
      t.references :item, foreign_key: true
      t.integer :rent_item_id

      t.timestamps
    end
  end
end
