class ItemsController < ApplicationController
  include ApplicationConcern

  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_items, only: %i[index]
  helper_method :sort_column, :sort_direction

  def index; end

  def show; end

  def new
    @item = current_user.items.build
  end

  def edit; end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
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

  def set_items
    @items = current_user.items.order("#{sort_column} #{sort_direction}")
                         .paginate(page: params[:page], per_page: 3).where(rent_item_id: nil)
    @lend_items = current_user.lend_items
    @borrowed_items = current_user.borrowed_items
  end
end
