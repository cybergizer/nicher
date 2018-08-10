class ItemsController < ApplicationController
  include ApplicationHelper

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
    @item = set_resource
  end

  def item_params
    model_params(:item)
  end
end
