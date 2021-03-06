module ApplicationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :set_resource, :model_params
  end

  def set_resource
    model_name.find_by!(id: params[:id], user: current_user)
  end

  def model_params(model)
    params.require(model).permit(model_name::PARAMS)
  end

  private

  def model_name
    controller_name.classify.constantize
  end
end
