class SharedItemsController < ApplicationController
  include SharedItemsConcern

  before_action :set_shared_item, only: %i[share]
  before_action :remove_expired_links, only: %i[share]

  def generate_link
    if item
      @shared_item = SharedItem.create(item: item)
      @link = share_url(token: @shared_item.token)
      render partial: 'items/popups/share_form'
    else
      redirect_to items_url, notice: "You don't have this item."
    end
  end

  def share
    if valid_params?
      item = @shared_item.item
      RentItem.create(item: item, owner: item.user, tenant: current_user)
      @shared_item.destroy
      redirect_to items_url, notice: "You've rent #{item.title} from #{item.user.first_name}."
    else
      redirect_to items_url, notice: 'Invalid Link.'
    end
  end

  private

  def valid_params?
    @shared_item && correct_members?
  end

  def item
    current_user.items.find_by(id: params[:id])
  end

  def correct_members?
    @shared_item.item.user != current_user
  end

  def set_shared_item
    @shared_item = SharedItem.find_by(token: params[:token])
  end
end
