class FreeItemRequestsController < ApplicationController
  before_action :set_free_item

  def new
    @request = FreeItemRequest.create(item: @item, actual_owner: @item.user, potential_owner: current_user)
    redirect_to root_path, notice: "You've sent request to this item's user."
  end

  def give_away
    @request = FreeItemRequest.find(params[:id])
    Item.create(title: @item.title, description: @item.description, user: @request.potential_owner, free: false)
    @item.destroy
    @request.destroy
    redirect_to root_path, notice: "Congrats, you're a good person!"
  end

  def filter_notifications
    @requests = current_user.pending_requests
  end

  def set_free_item
    @item = Item.find(params[:item_id])
  end
end
