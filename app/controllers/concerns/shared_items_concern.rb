module SharedItemsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :remove_expired_links
  end

  def remove_expired_links
    return unless @shared_item && @shared_item.expiration < Time.zone.now
    @shared_item.destroy
    @shared_item = nil
  end
end
