module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: %i[create]
    before_action :configure_account_update_params, only: %i[update]

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name])
    end
  end
end
