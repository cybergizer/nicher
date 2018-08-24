module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, only: %i[create]

    def new
      build_resource({})
      resource.build_user_profile
      respond_with self.resource
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u|
        u.permit(:email, :password, :password_confirmation, :remember_me, user_profile_attributes: [:first_name, :last_name]) }
    end
  end
end
