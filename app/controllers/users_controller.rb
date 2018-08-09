class UsersController < ApplicationController
  def show
    @user = current_user
    @user.user_profile = UserProfile.where(user_id: @user.id).first_or_create do |profile|
      profile.full_name = 'Some name'
      profile.city = 'Some city'
      profile.description = 'Some description'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_profile_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_profile_params
    params.require(:user).permit(user_profile_attributes: %i(full_name city description))
  end
end
