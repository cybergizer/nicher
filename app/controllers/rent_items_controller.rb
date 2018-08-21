class RentItemsController < ApplicationController
  include ApplicationConcern

  before_action :set_rent_item, only: %i[repay]
  before_action :set_borrowed_item, only: %i[show edit update]

  def rent_form
    @rent_item = RentItem.new(item: item)
    @rent_item.tenant = Contact.new
    render partial: 'items/popups/rent_form'
  end

  def rent
    @rent_item = RentItem.new(rent_item_params.merge(item: item, owner: current_user))
    if @rent_item.save
      item.update(niche: nil)
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }
    end
  end

  def repay
    @rent_item.destroy
    redirect_to items_url
  end

  def show; end

  def edit; end

  def update
    @rent_item.update(update_params)
    redirect_to @rent_item, notice: 'Item was successfully updated.'
  end

  private

  def set_rent_item
    @rent_item = RentItem.find_by!(id: params[:id], owner: current_user)
  end

  def rent_item_params
    params.require(:rent_item).permit(tenant_attributes: %i[name email phone_number], )
  end

  def update_params
    model_params(:rent_item)
  end

  def set_borrowed_item
    @rent_item = RentItem.find_by!(id: params[:id], tenant: current_user)
  end

  def item
    current_user.items.find(params[:id])
  end
end
