class SharedItemsController < ApplicationController
  def generate_link
    @shared_item = SharedItem.create(item: item)
    @link = rent_item_url(token: @shared_item.token)
    render partial: 'items/popups/share_form'
  end

  def rent_item
    shared_item = SharedItem.find_by(token: params[:token])
    if shared_item
      item = shared_item.item
      RentItem.create(item: item, owner: item.user, tenant: current_user)
      shared_item.destroy
      redirect_to items_url
    else
      redirect_to items_url, notice: 'Invalid Link'
    end
  end

  private

  def item
    current_user.items.find(params[:id])
  end
end
