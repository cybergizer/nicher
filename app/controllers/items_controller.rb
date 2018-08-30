class ItemsController < ApplicationController
  include ApplicationConcern

  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_paper_trail_whodunnit
  before_action :set_all_items, only: %i[index]
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
    @item = Item.find_by!(id: params[:id], user: current_user, rent_item_id: nil)
  end

  def item_params
    model_params(:item)
  end

  def set_all_items
    set_user_items
    @lend_items = current_user.lend_items.includes(:item)
    @borrowed_items = current_user.borrowed_items.includes(:item)
  end

  def set_user_items
    @items = current_user.items.includes(:category, :niche).order("#{sort_column} #{sort_direction}")
                         .paginate(page: params[:page], per_page: 3).where(rent_item_id: nil)
  end
end
