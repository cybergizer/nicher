class ItemsController < ApplicationController
  include ApplicationConcern

  before_action :set_item, only: %i[show edit update destroy rent_form]
  helper_method :sort_column, :sort_direction

  def index
    @items = current_user.items.order("#{sort_column} #{sort_direction}")
                         .paginate(page: params[:page], per_page: 3).where(rent_item_id: nil)
    @lend_items = current_user.lend_items
  end

  def show; end

  def new
    @item = current_user.items.build
  end

  def edit; end

  def rent_form
    @id = params[:id]
    @rent_item = RentItem.new
    @rent_item.tenant = Contact.new
    render partial: 'items/popups/rent_form'
  end

  def rent
    item = current_user.items.find(params[:id])
    @rent_item = RentItem.new(rent_item_params)
    @rent_item.item = item
    @rent_item.owner = current_user
    if @rent_item.save
      redirect_to items_url
    else
      @id = params[:id]
      render partial: 'items/popups/rent_form'
    end
  end

  def repay
    rent_item = RentItem.find(params[:id])
    rent_item.item = nil
    rent_item.save
    rent_item.destroy
    redirect_to items_url
  end

  def create
    @item = current_user.items.new(item_params)
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

  def rent_item_params
    params.require(:rent_item).permit(tenant_attributes: %i[name email phone_number])
  end

  def item_params
    model_params(:item)
  end
end
