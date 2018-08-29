# This helper extract 3 methods from Devise for 'Settings' view
module DeviseConcern
  extend ActiveSupport::Concern

  included do
    helper_method :devise_mapping, :resource_name, :resource_class
  end

  # Attempt to find the mapped route for devise based on request path
  # :reek:UtilityFunction
  def devise_mapping
    Devise.mappings[:user]
  end

  # Proxy to devise map name
  def resource_name
    devise_mapping.name
  end
  alias scope_name resource_name

  def resource_class
    devise_mapping.to
  end
end
