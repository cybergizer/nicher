class AddNichesToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :niches, :user, foreign_key: true
  end
end
