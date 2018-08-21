class AddNichesAndCategoriesToRentItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :rent_items, :niche, foreign_key: true
    add_reference :rent_items, :category, foreign_key: true
  end
end
