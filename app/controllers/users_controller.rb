class UsersController < ApplicationController
  include DeviseConcern
  before_action :set_user, only: :finish_signup

  def show
    @user_profile = user_profile
  end

  def edit
    current_user.build_user_profile unless current_user.user_profile
  end

  def update
    if current_user.update(user_profile_params)
      redirect_to current_user, notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  def finish_signup
    return unless request.patch? && params[:user]
    if @user.update(user_params)
      sign_in(@user, bypass: true)
      redirect_to new_user_session_url, notice: 'Your profile was successfully updated.'
    else
      @show_errors = true
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  def settings
    render :settings
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = %i[name email] # extend with your own params
    accessible << %i[password password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

  def user_profile
    current_user.user_profile
  end

  def user_profile_params
    params.require(:user).permit(user_profile_attributes: %i(full_name city description))
  end
end
