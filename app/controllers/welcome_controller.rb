class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.free.search(params[:search])
    @items = @items.includes(:rent_item, :free_item_request) if current_user
  end
end
