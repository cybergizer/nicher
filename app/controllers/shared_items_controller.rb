class SharedItemsController < ApplicationController
  before_action :set_shared_item, only: %i[rent_item]

  def generate_link
    @shared_item = SharedItem.create(item: item)
    @link = rent_item_url(token: @shared_item.token)
    render partial: 'items/popups/share_form'
  end

  def rent_item
    if valid_params?
      item = @shared_item.item
      RentItem.create(item: item, owner: item.user, tenant: current_user)
      @shared_item.destroy
      redirect_to items_url, notice: "You've rent #{item.title} from #{item.user.full_name}."
    else
      redirect_to items_url, notice: 'Invalid Link'
    end
  end

  private

  def valid_params?
    @shared_item && correct_members? && active_token?
  end

  def item
    current_user.items.find(params[:id])
  end

  def correct_members?
    @shared_item.item.user != current_user
  end

  def active_token?
    @shared_item.expiration > Time.zone.now
  end

  def set_shared_item
    @shared_item = SharedItem.find_by(token: params[:token])
  end
end
