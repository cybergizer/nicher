class FreeItemRequestsController < ApplicationController
  before_action :set_free_item, only: %i[give_away new]
  before_action :set_request, only: :give_away

  def new
    @request = FreeItemRequest.create(item: @item, actual_owner: @item.user, potential_owner: current_user)
    redirect_to root_path, notice: "You've sent request to this item's user."
  end

  def give_away
    Item.create(title: @item.title, description: @item.description, user: @request.potential_owner, free: false)
    @item.destroy
    @request.destroy
    redirect_to root_path, notice: "Congrats, you're a good person!"
  end

  def filter_notifications
    @requests = current_user.pending_requests
  end

  private

  def set_free_item
    @item = Item.find(params[:item_id])
  end

  def set_request
    @request = FreeItemRequest.find(params[:id])
  end
end
