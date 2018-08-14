class UsersController < ApplicationController
  include DeviseConcern
  before_action :set_user, only: %i[show edit update destroy finish_signup]

  def show
    @user_profile = user_profile
  end

  def edit
    current_user.build_user_profile unless current_user.user_profile
  end

  # PATCH/PUT /users/:id.:format
  # rubocop:disable Metrics/AbcSize
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params || user_profile)
        # redirect_to_current_user
        sign_in(@user == current_user ? @user : current_user, bypass: true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    return unless request.patch? && params[:user] # && params[:user][:email]
    if @user.update(user_params)
      # @user.skip_reconfirmation!
      sign_in(@user, bypass: true)
      redirect_to new_user_session_url, notice: 'Your profile was successfully updated.'
    else
      @show_errors = true
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
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
