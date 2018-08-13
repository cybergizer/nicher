class UsersController < ApplicationController
  def show
    @user_profile = user_profile
  end

  def edit
    current_user.build_user_profile unless current_user.user_profile
  end

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
    params.require(:user).permit(user_profile_attributes: %i(full_name city description avatar avatar_cache))
  end
end
