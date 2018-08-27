class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.where(free: true).search(params[:search])
  end
end
