class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = current_user.items
  end

  def show; end

  def new
    @item = current_user.items.create
  end

  def edit; end

  def create
    p item_params
    @item = current_user.items.create(item_params)

    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :location_id)
  end
end
