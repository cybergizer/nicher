class ItemsController < ApplicationController
  include ApplicationConcern

  before_action :set_item, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    @items = current_user.items.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 3)
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

  def sortable_columns
    %w[title created_at]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_item
    @item = set_resource
  end

  def item_params
    model_params(:item)
  end
end
