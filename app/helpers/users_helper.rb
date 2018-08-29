module UsersHelper
  def user_save(user)
    user.skip_confirmation!
    user.save!
    user
  end
end
