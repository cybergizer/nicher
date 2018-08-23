class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    define_method(provider.to_s) do
      @user = AuthService.new(request.env['omniauth.auth'], current_user).find_for_oauth
      if @user.persisted?
        access_granted(provider)
      else
        access_denied
      end
    end
  end

  %i[github facebook vkontakte yandex google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end

  def access_granted(provider)
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
  end

  def access_denied
    session["devise.#{provider}_data"] = request.env['omniauth.auth']
    redirect_to new_user_registration_url
  end
end
