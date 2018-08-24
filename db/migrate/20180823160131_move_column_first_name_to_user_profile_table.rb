class MoveColumnFirstNameToUserProfileTable < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :first_name, :string
    rename_column :user_profiles, :full_name, :last_name

    User.find_each do |user|
      if user.user_profile
        user.user_profile.update_columns(first_name: user.first_name)
      else
        user.create_user_profile(first_name: user.first_name)
      end
    end

    remove_column :users, :first_name
  end
end
