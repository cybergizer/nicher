class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.free.search(params[:search])
  end
end
