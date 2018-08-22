class CreateSharedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_items do |t|
      t.references :item, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
