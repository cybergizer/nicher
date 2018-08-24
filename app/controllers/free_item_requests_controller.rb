class FreeItemRequestsController < ApplicationController

  def new
    @item = Item.find_by_id(params[:item_id])
    if @item.free_item_request.nil?
      @request = FreeItemRequest.create(item: @item, actual_owner: @item.user, potential_owner: current_user)
      redirect_to root_path, notice: "You've sent request to this item's user."
    else
      redirect_to root_path, notice: "You've already sent request to take this item."
    end
  end
end
