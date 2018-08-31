class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if current_user
      if params[:search]
        @items = current_user.items.search(params[:search]).includes(:rent_item, :free_item_request)
      else
        @items = Item.free.includes(:rent_item, :free_item_request)
      end
    else
      @items = Item.free.search(params[:search]).sample(8)
    end
  end
end
