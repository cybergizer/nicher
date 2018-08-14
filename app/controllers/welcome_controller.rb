class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @items = Item.all.paginate(page: params[:page], per_page: 3)
  end
end
