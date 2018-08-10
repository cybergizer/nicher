class UsersController < ApplicationController
  def show
    @user_profile = UserProfile.find_or_create_by(user_id: current_user.id) do |profile|
      profile.full_name = 'Some name'
      profile.description = 'Some description'
      profile.city = 'Some city'
    end
  end

  def edit; end

  def update
    if current_user.update(user_profile_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  private

  def user_profile
    current_user.user_profile
  end

  def user_profile_params
    params.require(:user).permit(user_profile_attributes: %i(full_name city description))
  end
end
