module ApplicationHelper
  def set_resource
    model_name.find(params[:id])
  end

  def model_params(model)
    params.require(model).permit(model_name::PARAMS)
  end

  private

  def model_name
    controller_name.classify.constantize
  end
end
