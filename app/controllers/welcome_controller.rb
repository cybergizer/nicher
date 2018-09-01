class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_items, only: :index

  def index; end

  def set_items
    @items = Item.free.search(params[:search]).sample(8)
    set_items_for_user if current_user
  end

  def set_items_for_user
    @items = Item.free.includes(:rent_item, :free_item_request)
    @items = current_user.items.search(params[:search]).includes(:rent_item, :free_item_request) if params[:search]
  end

  def show_free_item
    @item = Item.free.find(params[:id])
    render 'show_free_item'
  end
end
