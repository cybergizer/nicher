class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.free.search(params[:search]).sample(8)
    set_items if current_user
  end

  def set_items
    @items = Item.free.includes(:rent_item, :free_item_request, :niche)
    @items = current_user.items.search(params[:search]).includes(:rent_item, :free_item_request, :niche) if params[:search]
  end
end
