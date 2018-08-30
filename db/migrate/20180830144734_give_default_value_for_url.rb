class GiveDefaultValueForUrl < ActiveRecord::Migration[5.2]
  def change
    change_column :niches, :url, :string, default: ''
  end
end
