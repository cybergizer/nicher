class AddItemsToNiches < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :niche, foreign_key: true
  end
end
