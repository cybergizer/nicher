class UsersController < ApplicationController
  include DeviseConcern
  layout 'devise', only: :finish_signup
  before_action :set_user, only: %i[finish_signup destroy]
  include ApplicationConcern
  before_action :set_user_profile, only: %i[show update]

  def show; end

  def edit; end

  def update
    if @user_profile.update(profile_params[:user_profile_attributes])
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

  def set_user_profile
    @user_profile = UserProfile.find_or_create_by(user_id: current_user.id)
  end

  def profile_params
    model_params(:user)
  end
end
