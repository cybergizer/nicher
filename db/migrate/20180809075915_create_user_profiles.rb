class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, index: true
      t.string :full_name
      t.string :city
      t.text :description
      t.timestamps
    end
  end
end
