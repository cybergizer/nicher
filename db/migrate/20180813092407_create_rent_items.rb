class CreateRentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :rent_items do |t|
      t.column :status, :integer
      t.timestamps
    end
  end
end
