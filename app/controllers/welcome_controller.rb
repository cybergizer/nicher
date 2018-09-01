class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_items, only: :index
  before_action :free_items_for_unauthorized_user, only: :index, if: -> { !current_user }

  def index; end

  def set_items
    @items = Item.includes(:rent_item, :free_item_request, :niche).for_user(current_user)
                 .or(Item.includes(:rent_item, :free_item_request, :niche).free.non_user(current_user))
    return if params[:search].blank?
    @items = @items.search(params[:search])
  end

  def show_free_item
    @item = Item.free.find(params[:id])
    render 'show_free_item'
  end

  private

  def free_items_for_unauthorized_user
    Item.free.search(params[:search]).sample(8)
  end
end
