class AddExpirationToSharedItem < ActiveRecord::Migration[5.2]
  def change
    add_column :shared_items, :expiration, :date
  end
end
