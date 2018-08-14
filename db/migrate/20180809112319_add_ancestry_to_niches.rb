class AddAncestryToNiches < ActiveRecord::Migration[5.2]
  def change
    add_column :niches, :ancestry, :string
    add_index :niches, :ancestry
  end
end
