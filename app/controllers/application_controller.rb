class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "You are not authorized to access this page: #{request.path}"
    redirect_to main_app.root_path, alert: exception.message
  end
end
