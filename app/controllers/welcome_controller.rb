class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @items = Item.all.paginate(page: params[:page], per_page: 3)
    @item_stats = Item.all.count
    @niche_stats = Niche.all.count
    @today = DateTime.now.strftime "%B %e, %Y"
    @searching_items = Item.search(params[:search])
  end
end
