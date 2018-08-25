class FreeItemRequestsController < ApplicationController
  def new
    @item = Item.find_by_id(params[:item_id])
    @request = FreeItemRequest.create(item: @item, actual_owner: @item.user, potential_owner: current_user)
    redirect_to root_path, notice: "You've sent request to this item's user."
  end

  def destroy
    @item = Item.find_by_id(params[:item_id])
    @request = FreeItemRequest.find_by_id(params[:id])
    Item.create(title: @item.title, description: @item.description, user: @request.potential_owner, free: false)
    @item.destroy
    @request.destroy
    redirect_to root_path, notice: "Congrats, you're a good person!"
  end

  def index
    @requests = current_user.pending_requests
  end
end
