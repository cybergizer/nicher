class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @searching_items = (current_user ? current_user.items.search(params[:search]) : [])
  end
end
