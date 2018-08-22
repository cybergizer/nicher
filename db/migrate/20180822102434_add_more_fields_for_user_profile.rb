class AddMoreFieldsForUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :sex, :string
    add_column :user_profiles, :phone, :string
    add_column :user_profiles, :birthday, :date
  end
end
