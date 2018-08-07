# rubocop:disable Style/ClassAndModuleChildren
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def facebook
    callback_from :facebook
  end

  def github
    callback_from :github
  end

  # :reek:UncommunicativeMethodName
  def google_oauth2
    callback_from :google_oauth2
  end

  private

  def set_user
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end

  def callback_from(provider)
    if @user.persisted?
      sign_in_and_redirect @user, event: %s[authentication] # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren
