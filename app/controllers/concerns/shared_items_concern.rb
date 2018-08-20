module SharedItemsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :remove_expired_links
  end

  def remove_expired_links
    @shared_item.destroy if @shared_item && @shared_item.expiration < Time.zone.now
  end
end
