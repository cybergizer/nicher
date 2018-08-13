class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: %i[new create update destroy]

  def ensure_signup_complete
    return unless action_name == 'finish_signup'
    # Redirect to finish_signup if user don't confirm email
    redirect_to finish_signup_path(current_user) if current_user && !current_user.email_verified?
  end
end
