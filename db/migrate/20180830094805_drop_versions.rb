class DropVersions < ActiveRecord::Migration[5.2]
  def change
    drop_table :versions
  end
end
