class AddAvatarToUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :avatar, :string
  end
end
