class UsersController < ApplicationController
  def show
    @user = current_user
    @user.user_profile ||= @user.build_user_profile
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
