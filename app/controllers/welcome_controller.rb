class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @searching_items = Item.search(params[:search])
  end
end
